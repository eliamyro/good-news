//
//  NewsTagCell.swift
//  GoodNews
//
//  Created by Elias Myronidis on 27/12/23.
//

import UIKit

class NewsTagCell: UICollectionViewCell {

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

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func configureUI() {
        configureContainerView()
        configureTitleLabel()
    }

    func setup(with model: NewsTag) {
        titleLabel.text = model.title
        containerView.backgroundColor = model.isSelected ? .red : .systemGray4
        titleLabel.textColor = model.isSelected ? .white : .black
    }

    private func configureContainerView() {
        contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2)
        ])
    }

    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6)
        ])
    }
}
