//
//  GetTopHeadlinesUC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 17/12/23.
//

import Combine
import Foundation

protocol GetTopHeadlinesUC {
    func execute(country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError>
}

class GetTopHeadlinesUCImp: GetTopHeadlinesUC {

    @Injected var repo: GoodNewsRepo

    func execute(country: String, category: String) -> AnyPublisher<APIArticlesResponse, RequestError> {
        repo.getTopHeadlines(for: country, category: category)
    }
}
