//
//  GoodNewsEndpoint.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

enum GoodNewsEndpoint {
    case topHeadlines(country: String, category: String)
    case downloadImage(imageUrl: String)
}

extension GoodNewsEndpoint: Endpoint {
    var host: String {
        switch self {
        case .topHeadlines:
            return "newsapi.org"
        case .downloadImage:
            return ""
        }
    }

    var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .downloadImage(let imageUrl):
            return imageUrl
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .topHeadlines(let country, let category):
            var queryItems = [
                URLQueryItem(name: "apiKey", value: APIKey.shared.apiKey),
                URLQueryItem(name: "country", value: country)
            ]
            
            if category != "All" {
                queryItems.append(URLQueryItem(name: "category", value: category))
            }

            return queryItems
        case .downloadImage:
            return []
        }
    }

    var method: RequestMethod {
        switch self {
        case .topHeadlines, .downloadImage:
                return .get
        }
    }
}
