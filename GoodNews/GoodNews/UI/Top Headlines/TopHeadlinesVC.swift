//
//  TopHeadlinesVC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import UIKit

class TopHeadlinesVC: UIViewController {

    // MARK: - Properties

    private var viewModel: TopHeadlinesVM

    // MARK: - Lifecycle

    init(viewModel: TopHeadlinesVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        viewModel.getTopHeadlines()
    }

    private func bind() {
        viewModel.$apiArticles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                // TODO: Reload tableview
            }
            .store(in: &viewModel.cancellables)
    }
}
