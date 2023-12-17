//
//  TopHeadlinesVM.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import Foundation

class TopHeadlinesVM {
    @Injected var getTopHeadlinesUC: GetTopHeadlinesUC

    @Published var apiArticles: [APIArticle] = []
    var cancellables = Set<AnyCancellable>()

    func getTopHeadlines() {
        // TODO: Add loader
        getTopHeadlinesUC.execute(country: "gr")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                // TODO: handle loader
                print(error.description)
            } receiveValue: { [weak self] articlesResponse in
                guard let self = self else { return }
                // TODO: handle loader
                print(articlesResponse.articles?[0].title)
                self.apiArticles.append(contentsOf: articlesResponse.articles ?? [])
            }
            .store(in: &cancellables)
    }
}
