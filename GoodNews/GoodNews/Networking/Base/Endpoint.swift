//
//  Endpoint.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem] { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }

    var header: [String: String]? {
        return ["Accept": "application/json"]
    }
}
