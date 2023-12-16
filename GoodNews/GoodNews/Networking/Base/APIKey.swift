//
//  APIKey.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Foundation

struct APIKey {
    static let shared = APIKey()

    private init() {}

    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
}
