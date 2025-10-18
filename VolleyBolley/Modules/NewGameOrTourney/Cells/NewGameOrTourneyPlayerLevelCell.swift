//
//  NewGameOrTourneyPlayerLevelCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 18.10.2025.
//

import UIKit

final class NewGameOrTourneyPlayerLevelCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyPlayerLevelCell"

	// MARK: - Private Properties

	private var callback: ((GamePlayerLevel) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMidle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let titleFontSize: CGFloat = 20
	}

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.playerLevel.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()
	private lazy var lightButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.light"), for: .normal)
		button.isSelected = true
		button.addAction(UIAction { [weak self] _ in
			self?.didLevelChanged(to: .light)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var mediumButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.medium"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didLevelChanged(to: .medium)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var hardButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.hard"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didLevelChanged(to: .hard)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var proButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.pro"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didLevelChanged(to: .pro)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var stackView: UIStackView = {
		lightButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		mediumButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		hardButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		proButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			lightButton,
			mediumButton,
			hardButton,
			proButton
		])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()

	private lazy var separator = CustomSeparator()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(callback: ((GamePlayerLevel) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyPlayerLevelCell {

	func didLevelChanged(to type: GamePlayerLevel) {
		lightButton.isSelected = type == .light
		mediumButton.isSelected = type == .medium
		hardButton.isSelected = type == .hard
		proButton.isSelected = type == .pro
		callback?(type)
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
	}

	func setupViews() {
		contentView.addSubviews(
			titleLabel,
			stackView
		)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			stackView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.insetMidle
			),
			stackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			stackView.trailingAnchor.constraint(
				lessThanOrEqualTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			)
		])
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyViewController()
}
#endif
