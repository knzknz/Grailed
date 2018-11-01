//
//  ArticleAPIClient .swift
//  Grailed_Feed
//
//  Created by C4Q on 10/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct ArticleAPIClient{
    private init() {}
    static var manager = ArticleAPIClient()

    var urlStr = "https://www.grailed.com/api/articles/ios_index"
    func getArticles(completionHandler: @escaping (ArticleWrapper) -> Void,
                errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let parseData = {(data: Data) in
            do {
                let onlineArticle = try? JSONDecoder().decode(ArticleWrapper.self, from: data)
                if let result = onlineArticle {
                    completionHandler(result)
                }
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseData, errorHandler: errorHandler)
    }
}

























