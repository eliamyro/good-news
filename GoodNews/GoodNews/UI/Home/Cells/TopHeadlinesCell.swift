//
//  TopHeadlinesCell.swift
//  GoodNews
//
//  Created by Elias Myronidis on 18/12/23.
//

import Combine
import UIKit

class TopHeadlinesCell: UITableViewCell {

    // MARK: - Properties

    @Injected var downloadImageUC: DownloadImageUC
    var cancellable: AnyCancellable?

    // MARK: - Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOffset = .init(width: 2, height: 2)

        return view
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var opacityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "denim")?.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 3
        label.textAlignment = .natural
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var publishedLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        configureContainerView()
        configurePosterImageView()
        configureOpacityView()
        configurePublishedLabel()
        configureAuthorLabel()
        configureTitleLabel()
    }

    // MARK: - Setup UI
    
    func setup(with model: APIArticle) {
        cancellable = downloadImageUC.execute(imageUrl: model.imageUrl ?? "")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                self.posterImageView.image = image
            }

        titleLabel.text = model.title ?? ""
        authorLabel.text = model.author
        publishedLabel.text = model.publishedAt?.formatedDate
    }

    private func configureContainerView() {
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 160),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    private func configurePosterImageView() {
        containerView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    private func configureOpacityView() {
        posterImageView.addSubview(opacityView)

        NSLayoutConstraint.activate([
            opacityView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            opacityView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            opacityView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            opacityView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor)
        ])
    }

    private func configurePublishedLabel() {
        posterImageView.addSubview(publishedLabel)

        NSLayoutConstraint.activate([
            publishedLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -8),
            publishedLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -8)
        ])
    }

    private func configureAuthorLabel() {
        posterImageView.addSubview(authorLabel)

        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8),
            authorLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -8),
            authorLabel.trailingAnchor.constraint(lessThanOrEqualTo: publishedLabel.leadingAnchor, constant: -8)
        ])
    }

    private func configureTitleLabel() {
        posterImageView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: authorLabel.topAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -8)
        ])
    }

}
