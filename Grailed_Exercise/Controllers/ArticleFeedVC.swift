//
//  ViewController.swift
//  Grailed_Exercise
//
//  Created by C4Q on 10/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit


class ArticleFeedVC: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var currentPageLabel: UILabel!
    
    var nextPage = ""
    var currentpage = ""
    var previous = ""
    
    var articles = [Article](){
        didSet {
            feedTableView.reloadData()
        }
    }
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = feedTableView.indexPathForSelectedRow{
            self.feedTableView.deselectRow(at: index, animated: true)
        }
        updateCurrentPageLbl()
    }
    
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        updateCurrentPageLbl()
        previousArticles()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        updateCurrentPageLbl()
        nextArticles()
    }
    
    func updateCurrentPageLbl() {
        if let updatedPage = currentpage.last {
            currentPageLabel.text = "Page \(updatedPage) out of 99"
        }
    }
    
    
    func resizeImage(imageUrl: String)-> String {
        let resizedImageUrl = "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:500,fit:crop/output=format:jpg,compress:true,quality:95/\(imageUrl)"
        return resizedImageUrl
    }
    
    func loadArticles() {
        ArticleAPIClient.manager.getArticles(completionHandler: { (articles) in
            self.articles = articles.data
            self.nextPage = articles.metadata.pagination.next_page ?? articles.metadata.pagination.current_page
            self.currentpage = articles.metadata.pagination.current_page
            self.previous = articles.metadata.pagination.previous_page ?? articles.metadata.pagination.current_page
        }, errorHandler: {print($0)})
    }
    
    func nextArticles() {
        ArticleAPIClient.manager.urlStr = "https://www.grailed.com\(nextPage)"
        loadArticles()
    }
    
    func previousArticles() {
        ArticleAPIClient.manager.urlStr = "https://www.grailed.com\(previous)"
        loadArticles()
    }
    
}

extension ArticleFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "articleCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleCell  else {
            fatalError("The dequeued cell is not an instance of ArticleCell.")
        }
        
        let article = articles[indexPath.row]
        
        cell.articleTitleLabel.text = article.title
        
        let dateString = article.publishedDate
        let fixedDate = formatDate(from: dateString!)
        cell.articleDateLabel.text = fixedDate
        
        cell.articleImage.image = nil
        
        DispatchQueue.main.async {
            ImageAPIClient.manager.getImage(from: self.resizeImage(imageUrl: article.imageUrl ?? "https://unsplash.com/photos/Dz-lPF200Rg"),
                                            completionHandler: {cell.articleImage.image = $0; cell.setNeedsLayout(); self.images.append($0)},
                                            errorHandler: {print($0)})
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue" {
            let cell = sender as! ArticleCell
            if let indexPath = self.feedTableView.indexPath(for: cell){
                if let destinationVC = segue.destination as? ArticleDetailVC {
                    destinationVC.article = articles[indexPath.row]
                    
                    destinationVC.image = cell.articleImage.image
                    
                }
            }
        }
    }
    
}

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }
    
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        return formatter
    }()
}

