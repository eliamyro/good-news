//
//  GoodNewsEndpoint.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

enum GoodNewsEndpoint {
    case topHeadlines(country: String)
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
        case .topHeadlines(let country):
            return [
                URLQueryItem(name: "apiKey", value: APIKey.shared.apiKey),
                URLQueryItem(name: "country", value: country)
            ]
        }
    }

    var method: RequestMethod {
        switch self {
        case .topHeadlines:
                return .get
        }
    }
}
