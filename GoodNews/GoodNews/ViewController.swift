//
//  ViewController.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import Combine
import UIKit

class ViewController: UIViewController {

    //  Testing
    @Injected var dummyUC: DummyUC
    @Injected var repo: GoodNewsRepo
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        print(APIKey.shared.apiKey)
        print(dummyUC.execute())
        fetchTopHeadlines(for: "gr")
    }

    // testing
    func fetchTopHeadlines(for country: String) {
        repo.getTopHeadlines(for: country)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                guard case .failure(let error) = completion else { return }
                print(error.description)
            } receiveValue: { [weak self] response in
                guard let self else { return }

                let articles = response.articles ?? []
                for article in articles {
                    print("Article: \(article.author)")
                }
            }
            .store(in: &cancellables)

    }
}
