//
//  ArticleDetailVC.swift
//  Grailed_Exercise
//
//  Created by C4Q on 10/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ArticleDetailVC: UIViewController {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    
    var passedTitle = ""
    var passedDate = ""
    var passedImage = UIImage()
    
    var article: Article!
    var image: UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
    }
    
    func configureOutlets() {
        articleTitleLabel.text = article.title
        let dateString = article.publishedDate
        let fixedDate = formatDate(from: dateString!)
        articleDateLabel.text = fixedDate
        articleImage.image = image
    }

}
