//
//  RegistrationPlayerLevelCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

struct RegistrationPlayerLevelCellViewModel {
	let levelAction: (() -> Void)
	let callback: ((PlayerLevel) -> Void)?
}

final class RegistrationPlayerLevelCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "RegistrationPlayerLevelCell"

	// MARK: - Private Properties

	private var levelAction: (() -> Void) = {}
	private var callback: ((PlayerLevel) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let levelInfoButtonSize: CGFloat = 18

		static let stackViewSpacing: CGFloat = 8
	}

	private lazy var titleLabel = CustomLabel(text: String(localized: "Level"), isBold: true)

	private lazy var levelInfoButton: UIButton = {
		var config = UIButton.Configuration.plain()
		config.image = UIImage.Icon.tooltip
		config.imagePlacement = .leading
		let button = UIButton(configuration: config)
		button.addAction(UIAction { [weak self] _ in
			self?.levelAction()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var levelCaptionStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			titleLabel,
			levelInfoButton
		])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()

	private lazy var lightButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.light").capitalized, for: .normal)
		setupToggleButton(button, level: .light) { [weak self] level in
			self?.didLevelsChanged(to: level)
		}
		return button
	}()

	private lazy var mediumButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.medium").capitalized, for: .normal)
		setupToggleButton(button, level: .medium) { [weak self] level in
			self?.didLevelsChanged(to: level)
		}
		return button
	}()

	private lazy var hardButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.hard").capitalized, for: .normal)
		setupToggleButton(button, level: .hard) { [weak self] level in
			self?.didLevelsChanged(to: level)
		}
		return button
	}()

	private lazy var proButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "common.pro").capitalized, for: .normal)
		setupToggleButton(button, level: .pro) { [weak self] level in
			self?.didLevelsChanged(to: level)
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

	func configure(model: RegistrationPlayerLevelCellViewModel) {
		levelAction = model.levelAction
		callback = model.callback
	}
}

// MARK: - Private Methods

private extension RegistrationPlayerLevelCell {

	func setupToggleButton(
		_ button: UIButton,
		level: PlayerLevel,
		action: @escaping (PlayerLevel) -> Void
	) {
		button.addAction(UIAction { [weak self] _ in
			self?.didLevelsChanged(to: level)
		}, for: .touchUpInside)
	}

	func didLevelsChanged(to playerLevel: PlayerLevel) {
		lightButton.isSelected = playerLevel == .light
		mediumButton.isSelected = playerLevel == .medium
		hardButton.isSelected = playerLevel == .hard
		proButton.isSelected = playerLevel == .pro
		callback?(playerLevel)
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
	}

	func setupViews() {
		contentView.addSubviews(
			levelCaptionStackView,
			stackView,
			separator
		)
		NSLayoutConstraint.activate([
			levelCaptionStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			levelCaptionStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			levelInfoButton.widthAnchor.constraint(equalToConstant: Constants.levelInfoButtonSize),
			levelInfoButton.heightAnchor.constraint(equalToConstant: Constants.levelInfoButtonSize),

			stackView.topAnchor.constraint(
				equalTo: levelCaptionStackView.bottomAnchor,
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

			separator.topAnchor.constraint(
				equalTo: stackView.bottomAnchor,
				constant: Constants.inset
			),
			separator.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			separator.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			separator.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.inset
			)
		])
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	VStack {
		UIViewPreview {
			let cell = RegistrationPlayerLevelCell(style: .default, reuseIdentifier: nil)
			let levelAction: () -> Void = {
				print("levelAction: level btn tapped")
			}
			let model = RegistrationPlayerLevelCellViewModel(levelAction: levelAction) { level in
				print("level: \(level)")
			}
			cell.configure(model: model)
			return cell
		}
		.frame(maxHeight: 110)
	}
	.padding(.vertical)
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
