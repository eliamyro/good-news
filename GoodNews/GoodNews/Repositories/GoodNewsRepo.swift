//
//  GoodNewsRepo.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import UIKit

protocol GoodNewsRepo {
    func getTopHeadlines(for country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError>
    func downloadImage(imageUrl: String) -> AnyPublisher<UIImage?, Never>
}

class GoodNewsRepoImp: GoodNewsRepo {
    @Injected var client: HTTPClient

    func getTopHeadlines(for country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError> {
        return client.sendRequest(endpoint: GoodNewsEndpoint.topHeadlines(country: country,
                                                                          category: category),
                                  responseType: APIArticlesResponse.self)
    }

    func downloadImage(imageUrl: String) -> AnyPublisher<UIImage?, Never> {
        return client.downloadImage(endpoint: GoodNewsEndpoint.downloadImage(imageUrl: imageUrl))
    }
}
