//
//  CourtBottomView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

final class CourtBottomView: UIView {

    // MARK: - Public Properties

    lazy var chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose this court", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    lazy var detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Details", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Private Properties

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    private lazy var nearestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGreen
        label.text = "nearest"
        label.isHidden = true
        return label
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        addSubview(stack)
        return stack
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Public Methods

    func configure(with court: CourtModel, isNearest: Bool) {
        nameLabel.text = court.name
        shortDescriptionLabel.text = court.shortDescription
        nearestLabel.isHidden = !isNearest
    }
}

// MARK: - Private Methods

private extension CourtBottomView {

    func setupUI() {
        backgroundColor = .white// TODO
        layer.cornerRadius = 20
        layer.masksToBounds = true
        // button stack
        [
            chooseButton,
            detailsButton
        ].forEach {
            buttonStack.addArrangedSubview($0)
        }
        // main stack
        [
            nameLabel,
            shortDescriptionLabel,
            nearestLabel,
            buttonStack
        ].forEach {
            mainStack.addArrangedSubview($0)
        }

        addSubviews(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
