//
//  GoodNewsEndpoint.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

enum GoodNewsEndpoint {
    case topHeadlines(country: String, category: String)
}

extension GoodNewsEndpoint: Endpoint {
    var host: String {
        switch self {
        case .topHeadlines:
            return "newsapi.org"
        }
    }

    var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
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
        }
    }

    var method: RequestMethod {
        switch self {
        case .topHeadlines:
                return .get
        }
    }
}
