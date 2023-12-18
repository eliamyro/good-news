//
//  TopHeadlinesVM.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import Foundation
import UIKit

enum DiffableSection: Hashable {
    case main
}

class TopHeadlinesVM {
    @Injected var getTopHeadlinesUC: GetTopHeadlinesUC

    @Published var apiArticles: [APIArticle] = []
    var cancellables = Set<AnyCancellable>()
    var diffableDataSource: UITableViewDiffableDataSource<DiffableSection, APIArticle>?
    var snapshot = NSDiffableDataSourceSnapshot<DiffableSection, APIArticle>()

    func getTopHeadlines() {
        getTopHeadlinesUC.execute(country: "gr")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { [weak self] articlesResponse in
                guard let self = self else { return }
                self.apiArticles.append(contentsOf: articlesResponse.articles ?? [])
                self.applySnapshot()
            }
            .store(in: &cancellables)
    }

    private func applySnapshot() {
        snapshot.appendSections([.main])
        snapshot.appendItems(apiArticles)

        if let diffableDataSource {
            diffableDataSource.apply(snapshot, animatingDifferences: false)
        }
    }
}
