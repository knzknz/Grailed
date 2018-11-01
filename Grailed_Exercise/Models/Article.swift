//
//  Article.swift
//  Grailed_Feed
//
//  Created by C4Q on 10/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct ArticleWrapper: Codable {
    let data: [Article]
    let metadata: PaginationWrapper
}

struct PaginationWrapper: Codable {
    let pagination: Page
}

struct Page: Codable {
    let next_page: String?
    let current_page: String
    let previous_page: String?
}

struct Article: Codable {
    let title: String?
    let publishedDate: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_at"
        case imageUrl = "hero"
    }
}
