//
//  HomeVM.swift
//  GoodNews
//
//  Created by Elias Myronidis on 27/12/23.
//

import Combine
import UIKit

class HomeVM {
    @Injected var getTopHeadlinesUC: GetTopHeadlinesUC

    var tags = NewsTag.categories

    @Published var apiArticles: [APIArticle] = []
    @Published var selectedCategory: String = "All"
    @Published var indicatorStatus: ActivityIndicatorStatus = .success
    var cancellables = Set<AnyCancellable>()

    var tagsDiffableDataSource: UICollectionViewDiffableDataSource<DiffableSection, NewsTag>?
    var tagsSnapshot = NSDiffableDataSourceSnapshot<DiffableSection, NewsTag>()
    var articlesDiffableDataSource: UITableViewDiffableDataSource<DiffableSection, APIArticle>?
    var articlesSnapshot = NSDiffableDataSourceSnapshot<DiffableSection, APIArticle>()

    init() {
        bind()
    }

    private func bind() {
        $selectedCategory.receive(on: DispatchQueue.main)
            .sink { _ in
                self.getTopHeadlines()
            }
            .store(in: &cancellables)
    }

    func applyTagsSnapshot() {
        tagsSnapshot.deleteAllItems()
        tagsSnapshot.appendSections([.main])
        tagsSnapshot.appendItems(tags)

        if let tagsDiffableDataSource {
            tagsDiffableDataSource.apply(tagsSnapshot, animatingDifferences: true)
        }
    }

    private func applyArticlesSnapshot() {
        articlesSnapshot.deleteAllItems()
        articlesSnapshot.appendSections([.main])
        articlesSnapshot.appendItems(apiArticles)

        if let articlesDiffableDataSource {
            articlesDiffableDataSource.apply(articlesSnapshot, animatingDifferences: false)
        }
    }

    func getTopHeadlines() {
        indicatorStatus = .loading
        
        getTopHeadlinesUC.execute(country: "us", category: selectedCategory)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                guard case .failure(let error) = completion else { return }
                self.indicatorStatus = .error
                print(error.description)
            } receiveValue: { [weak self] articlesResponse in
                guard let self else { return }
                self.indicatorStatus = .success
                self.apiArticles = articlesResponse.articles?.filter { !($0.title?.lowercased().contains("removed") ?? false) } ?? []
                self.applyArticlesSnapshot()
            }
            .store(in: &cancellables)

    }
}
