//
//  APIArticlesResponse.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

struct APIArticlesResponse: Codable, Equatable {
    var totalResults: Int?
    var articles: [APIArticle]?
}

struct APIArticle: Codable, Equatable {
    var source: APIArticleSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var imageUrl: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, publishedAt, content
        case imageUrl = "imageToUrl"
    }
}

struct APIArticleSource: Codable, Equatable {
    var id: String?
    var name: String?
}
