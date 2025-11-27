//
//  СhoiceTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 27.11.2025.
//

import UIKit

struct PlayerListCellViewModel {
    let name: String
    let isFavorite: Bool
	let level: String
	let onFavoriteToggle: (() -> Void)?

	init(
		name: String,
		isFavorite: Bool,
		level: String,
		onFavoriteToggle: (() -> Void)?
	) {
		self.name = name
		self.isFavorite = isFavorite
		self.level = String(level.prefix(1).uppercased())
		self.onFavoriteToggle = onFavoriteToggle
	}
}

final class PlayersListViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "PlayersListViewCell"

	private enum Constants {
		static let horizontalInset: CGFloat = 8

		static let badgeWidth: CGFloat = 30
		static let badgeHeight: CGFloat = 23

		static let fontSize: CGFloat = 16
	}

    // MARK: - Private Properties

    private var isFavorite: Bool = false
	private var onFavoriteToggle: (() -> Void)?

    private lazy var starButton: UIButton = {
        let button = UIButton()
		button.setImage(UIImage.Icon.noStar, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didTapStar()
		}, for: .touchUpInside)
        return button
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.Text.primary
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
        return label
    }()

    private lazy var leftStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel])
        stack.axis = .horizontal
        stack.alignment = .center
		stack.spacing = Constants.horizontalInset
        return stack
    }()

    private lazy var badgeView = BadgeView()

    private lazy var rightStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			starButton,
			badgeView
		])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = Constants.horizontalInset
        return stack
    }()

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
			leftStack,
			rightStack
		])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
		stack.spacing = Constants.horizontalInset
        return stack
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
        selectionStyle = .none
		setupUI()
    }

	@available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Public Method

    func configure(with model: PlayerListCellViewModel) {
        nameLabel.text = model.name
        isFavorite = model.isFavorite
		badgeView.configure(distance: model.level)
		onFavoriteToggle = model.onFavoriteToggle
        updateUI()
    }
}

// MARK: - Private methods

private extension PlayersListViewCell {

	func didTapStar() {
		isFavorite.toggle()
		updateUI()
		onFavoriteToggle?()
	}

	func updateUI() {
		starButton.setImage(isFavorite
			? UIImage.Icon.star
			: UIImage.Icon.noStar,
		for: .normal)
	}

    func setupUI() {
		contentView.addSubviews(mainStack)
        setupConstraints()
    }

    func setupConstraints() {
        leftStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        rightStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        NSLayoutConstraint.activate([
			badgeView.widthAnchor.constraint(equalToConstant: Constants.badgeWidth),
			badgeView.heightAnchor.constraint(equalToConstant: Constants.badgeHeight),

            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	PlayersListViewController()
}
#endif
