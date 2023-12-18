//
//  TopHeadlinesVC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 16/12/23.
//

import UIKit

class TopHeadlinesVC: UIViewController, UITableViewDelegate {

    // MARK: - Properties

    private var viewModel: TopHeadlinesVM

    // MARK: - Views

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndcator = UIActivityIndicatorView(style: .large)
        activityIndcator.hidesWhenStopped = true
        activityIndcator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndcator
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        viewModel.diffableDataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
        }

        return tableView
    }()

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

        setupUI()
        bind()

        viewModel.getTopHeadlines()
    }

    // MARK: - Setup UI

    private func setupUI() {
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
    }

    private func setupNavigationBar() {
        view.backgroundColor = .systemBackground
    }

    private func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupActivityIndicator() {
        view .addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func bind() {
        viewModel.$indicatorStatus
            .receive(on: RunLoop.main)
            .sink { [weak self] status in
                guard let self else { return }
                switch status {
                case .loading:
                    self.activityIndicator.startAnimating()
                default:
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &viewModel.cancellables)
    }
}
