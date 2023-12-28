//
//  GoodNewsRepo.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import Foundation

protocol GoodNewsRepo {
    func getTopHeadlines(for country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError>
}

class GoodNewsRepoImp: GoodNewsRepo {
    @Injected var client: HTTPClient

    func getTopHeadlines(for country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError> {
        return client.sendRequest(endpoint: GoodNewsEndpoint.topHeadlines(country: country,
                                                                          category: category),
                                  responseType: APIArticlesResponse.self)
    }
}
