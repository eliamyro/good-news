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

struct APIArticle: Codable, Equatable, Hashable {
    let id = UUID().uuidString
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

    public func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
    }
}

struct APIArticleSource: Codable, Equatable {
    var id: String?
    var name: String?
}

extension APIArticlesResponse {
    static var fakeAPIArticlesResponse = APIArticlesResponse(totalResults: 1, articles: [
        APIArticle(source: APIArticleSource(id: "Dummy id", name: "Dummy source name"),
                   author: "Dummy author",
                   title: "Dummy title",
                  description: "Dummy description",
                   url: "http://www.dummyUrl",
                  imageUrl: "http://www.dummyUrlToImage",
                  publishedAt: "2023-12-30",
                  content: "Dummy content")
    ])
}
