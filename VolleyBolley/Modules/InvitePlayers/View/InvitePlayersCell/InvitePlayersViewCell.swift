//
//  InvitePlayersViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import UIKit

final class InvitePlayersViewCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "InvitePlayersViewCell"

	private enum Constants {
		static let stackSpacing: CGFloat = 8

		static let badgeWidth: CGFloat = 30
		static let badgeHeight: CGFloat = 23

		static let fontSize: CGFloat = 16
	}

	// MARK: - Private Properties

	private var isFavorite: Bool = false
	private var isPlayerSelected: Bool = false
	private var onFavoriteToggle: ((Bool) -> Void)?
	private var onCheckmarkToggle: ((Bool) -> Void)?

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
		let stack = UIStackView(arrangedSubviews: [starButton, nameLabel])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = Constants.stackSpacing
		return stack
	}()

	private lazy var badgeView = BadgeView()

	private lazy var checkmarkButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.Icon.empty, for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didTapCheckmark()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var rightStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [badgeView, checkmarkButton])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = Constants.stackSpacing
		return stack
	}()

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [leftStack, rightStack])
		stack.axis = .horizontal
		stack.alignment = .center
		stack.distribution = .equalSpacing
		return stack
	}()

	private lazy var noPlayersLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		label.textColor = AppColor.Text.primary
		label.text = String(localized: "playersList.noPlayers")
		label.isHidden = true
		return label
	}()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Method

	func configure(with model: InvitePlayersCellViewModel) {
		noPlayersLabel.isHidden = true
		mainStack.isHidden = false

		nameLabel.text = model.name

		isFavorite = model.isFavorite
		setupStarButton()
		isPlayerSelected = model.isSelected

		badgeView.configure(distance: model.level)
		onFavoriteToggle = model.onFavoriteToggle

		checkmarkButton.isUserInteractionEnabled = model.isUserInteractionEnabled
		setupCheckmarkButton()
		onCheckmarkToggle = model.onCheckmarkToggle
	}

	func configureAsNoPlayers() {
		noPlayersLabel.isHidden = false
		mainStack.isHidden = true
	}
}

// MARK: - Private methods

private extension InvitePlayersViewCell {

	func didTapStar() {
		isFavorite.toggle()
		setupStarButton()
		onFavoriteToggle?(isFavorite)
	}

	func setupStarButton() {
		starButton.setImage(isFavorite ? UIImage.Icon.star : UIImage.Icon.noStar, for: .normal)
	}

	func setupCheckmarkButton() {
		let emptyImage = !isPlayerSelected && checkmarkButton.isUserInteractionEnabled
		? UIImage.Icon.empty
		: UIImage.Icon.empty.withTintColor(.systemGray3)
		checkmarkButton.setImage(isPlayerSelected ? UIImage.Icon.filled : emptyImage, for: .normal)
	}

	func didTapCheckmark() {
		isPlayerSelected.toggle()
		setupCheckmarkButton()
		onCheckmarkToggle?(isPlayerSelected)
	}

	func setupUI() {
		contentView.addSubviews(
			mainStack,
			noPlayersLabel
		)
	}

	func setupView() {
		setupUI()

		mainStack.pinToSuperviewEdges()

		NSLayoutConstraint.activate([
			badgeView.widthAnchor.constraint(equalToConstant: Constants.badgeWidth),
			badgeView.heightAnchor.constraint(equalToConstant: Constants.badgeHeight),

			noPlayersLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			noPlayersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			noPlayersLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
