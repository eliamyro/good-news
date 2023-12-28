//
//  TopHeadlinesCell.swift
//  GoodNews
//
//  Created by Elias Myronidis on 18/12/23.
//

import UIKit

class TopHeadlinesCell: UITableViewCell {

    // MARK: - Views

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        view.layer.shadowOffset = .init(width: 2, height: 2)

        return view
    }()

    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.textAlignment = .natural
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

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
        configureImageContainerView()
        configureTitleLabel()
    }

    // MARK: - Setup UI
    
    func setup(with model: APIArticle) {
        titleLabel.text = model.title ?? ""
    }

    private func configureContainerView() {
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    private func configureImageContainerView() {
        containerView.addSubview(imageContainerView)

        NSLayoutConstraint.activate([
            imageContainerView.heightAnchor.constraint(equalToConstant: 160),
            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageContainerView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -80),
            imageContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    private func configureTitleLabel() {
        imageContainerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageContainerView.bottomAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -8)
        ])
    }
}
