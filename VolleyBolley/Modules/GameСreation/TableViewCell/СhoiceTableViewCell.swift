//
//  СhoiceTableViewCell.swift
//  VolleyBolley
//
//  Created by Вадим on 23.08.2025.
//

import UIKit

struct PlayerCellModel {
    let name: String
    let isFavorite: Bool
    let isSelected: Bool
}

final class PlayerCell: UITableViewCell {

    // MARK: - Public Properties

    static let playerCellidentifier = "PlayerCell"

    var onFavoriteToggle: (() -> Void)?
    var onCheckmarkToggle: (() -> Void)?

    // MARK: - Private Properties

    private var isFavorite: Bool = false
    private var isChecked: Bool = false

    private lazy var starButton: UIButton = {
        let button = UIButton()
		button.setImage(UIImage.Icon.noStar, for: .normal)
        button.addTarget(self, action: #selector(didTapStar), for: .touchUpInside)
        return button
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
        label.font = AppFont.Hero.regular(size: 16)
        return label
    }()

    private lazy var leftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starButton, nameLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    private lazy var badgeView = BadgeView()

    private lazy var checkmarkButton: UIButton = {
        let button = UIButton()
		button.setImage(UIImage.Icon.empty, for: .normal)
        button.addTarget(self, action: #selector(didTapCheckmark), for: .touchUpInside)
        return button
    }()

    private lazy var rightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [badgeView, checkmarkButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftStack, rightStack])
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

    func configure(with model: PlayerCellModel) {
        nameLabel.text = model.name
        self.isFavorite = model.isFavorite
        self.isChecked = model.isSelected
        updateUI()
    }

    // MARK: - Private Method

    private func updateUI() {
		starButton.setImage(isFavorite ? UIImage.Icon.star : UIImage.Icon.noStar, for: .normal)
		checkmarkButton.setImage(isChecked ? UIImage.Icon.filled : UIImage.Icon.empty, for: .normal)
    }

    @objc private func didTapStar() {
        isFavorite.toggle()
        updateUI()
        onFavoriteToggle?()
    }

    @objc private func didTapCheckmark() {
        isChecked.toggle()
        updateUI()
        onCheckmarkToggle?()
    }
}

// MARK: - Private methods

private extension PlayerCell {

    func setupUI() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupView() {
        setupUI()

        NSLayoutConstraint.activate([
            badgeView.widthAnchor.constraint(equalToConstant: 30),
            badgeView.heightAnchor.constraint(equalToConstant: 23),

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
