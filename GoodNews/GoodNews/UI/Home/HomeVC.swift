//
//  HomeVC.swift
//  GoodNews
//
//  Created by Elias Myronidis on 27/12/23.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties

    private var viewModel: HomeVM

    // MARK: - Views

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndcator = UIActivityIndicatorView(style: .large)
        activityIndcator.hidesWhenStopped = true
        activityIndcator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndcator
    }()

    private lazy var tagsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(NewsTagCell.self, forCellWithReuseIdentifier: NewsTagCell.cellIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        viewModel.tagsDiffableDataSource =
        UICollectionViewDiffableDataSource<DiffableSection, NewsTag>(collectionView: collectionView) { collectionView, indexPath, model -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsTagCell.cellIdentifier,
                                                                for: indexPath) as? NewsTagCell else {
                return UICollectionViewCell()
            }
            cell.setup(with: model)
            return cell
        }
        return collectionView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(TopHeadlinesCell.self, forCellReuseIdentifier: TopHeadlinesCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        viewModel.articlesDiffableDataSource =
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, model -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopHeadlinesCell.cellIdentifier,
                                                           for: indexPath) as? TopHeadlinesCell else { return UITableViewCell() }
            cell.setup(with: model)
            return cell
        }

        return tableView
    }()

    // MARK: - Lifecycle

    init(viewModel: HomeVM) {
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
        viewModel.applyTagsSnapshot()
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

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupTagsCollectionView()
        setupArticlesTableView()
        setupActivityIndicator()

    }

    private func setupTagsCollectionView() {
        view.addSubview(tagsCollectionView)

        NSLayoutConstraint.activate([
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 50),
            tagsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tagsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tagsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }

    private func setupArticlesTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in viewModel.tags.indices {
            viewModel.tags[index].isSelected = false
        }

        viewModel.tags[indexPath.item].isSelected = true
        viewModel.selectedCategory = viewModel.tags[indexPath.item].title
        viewModel.applyTagsSnapshot()
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.apiArticles[indexPath.row]
        let controller = ArticleDetailsVC(viewModel: ArticleDetailsVM(article: article))
        navigationController?.pushViewController(controller, animated: true)

    }
}
