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

	private var callback: (([PlayerLevel]) -> Void)?
	private var playerLevels: [PlayerLevel] = []

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
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
		button.setTitle(String(localized: "common.light").capitalized, for: .normal)
		setupToggleButton(button, level: .light) { [weak self] level in
			self?.didLevelsChanged(with: level)
		}
		return button
	}()

	private lazy var mediumButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.medium").capitalized, for: .normal)
		setupToggleButton(button, level: .medium) { [weak self] level in
			self?.didLevelsChanged(with: level)
		}
		return button
	}()

	private lazy var hardButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.hard").capitalized, for: .normal)
		setupToggleButton(button, level: .hard) { [weak self] level in
			self?.didLevelsChanged(with: level)
		}
		return button
	}()

	private lazy var proButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.pro").capitalized, for: .normal)
		setupToggleButton(button, level: .pro) { [weak self] level in
			self?.didLevelsChanged(with: level)
		}
		return button
	}()

	private lazy var stackView: UIStackView = {
		lightButton.setContentHuggingPriority(.required, for: .horizontal)
		mediumButton.setContentHuggingPriority(.required, for: .horizontal)
		hardButton.setContentHuggingPriority(.required, for: .horizontal)
		proButton.setContentHuggingPriority(.required, for: .horizontal)
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

	func configure(callback: (([PlayerLevel]) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyPlayerLevelCell {

	func setupToggleButton(
		_ button: UIButton,
		level: PlayerLevel,
		action: @escaping (PlayerLevel) -> Void
	) {
		button.addAction(UIAction { [weak self] _ in
			button.isSelected.toggle()
			self?.didLevelsChanged(with: level)
		}, for: .touchUpInside)
	}

	func didLevelsChanged(with type: PlayerLevel) {
		playerLevels.toggle(type)
		callback?(playerLevels)
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
				constant: Constants.insetMiddle
			),
			stackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			stackView.trailingAnchor.constraint(
				lessThanOrEqualTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			stackView.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.inset
			)
		])
	}
}

#if DEBUG

// MARK: - Preview

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyAssembly.createModule(with: nil)
}
#endif
