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
}

struct APIArticleSource: Codable, Equatable {
    var id: String?
    var name: String?
}
