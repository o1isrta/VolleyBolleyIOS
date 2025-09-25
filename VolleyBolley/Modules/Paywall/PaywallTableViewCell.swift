//
//  PaywallTableViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 25.09.2025.
//

import UIKit

struct PaywallPlayerCellModel {
    let name: String
}

final class PaywallPlayerCell: UITableViewCell {

    // MARK: - Public Properties

    static let paywallplayerCellidentifier = "PaywallPlayerCell"

    var onDelete: (() -> Void)?

    // MARK: - Private Properties

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        return label
    }()

    private lazy var distanceView = DistanceView()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Icon.delete, for: .normal)
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()

    private lazy var rightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [distanceView, deleteButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, rightStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    func configure(with model: PaywallPlayerCellModel) {
        nameLabel.text = model.name
    }

    // MARK: - Actions

    @objc private func didTapDelete() {
        onDelete?()
    }
}

// MARK: - Private methods

private extension PaywallPlayerCell {

    func setupUI() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            distanceView.widthAnchor.constraint(equalToConstant: 30),
            distanceView.heightAnchor.constraint(equalToConstant: 23),

            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
