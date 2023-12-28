//
//  ArticleDetailsVC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 28/12/23.
//

import UIKit

class ArticleDetailsVC: UIViewController {

    // MARK: - Properties

    let viewModel: ArticleDetailsVM

    // MARK: - Lifecycle

    init(viewModel: ArticleDetailsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .green
        navigationItem.title = viewModel.article.title
    }
}
