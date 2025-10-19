//
//  NewGameOrTourneyGenderCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 18.10.2025.
//

import UIKit

final class NewGameOrTourneyGenderCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyGenderCell"

	// MARK: - Private Properties

	private var callback: ((GameGenderType) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMidle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let titleFontSize: CGFloat = 20
	}

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "gender.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		return label
	}()
	private lazy var mixButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "gender.mix"), for: .normal)
		button.isSelected = true
		button.addAction(UIAction { [weak self] _ in
			self?.didGenderChanged(to: .mix)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var menButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "gender.men"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didGenderChanged(to: .men)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var womenButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "gender.women"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didGenderChanged(to: .women)
		}, for: .touchUpInside)
		return button
	}()
	private lazy var stackView: UIStackView = {
		mixButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		menButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		womenButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			mixButton,
			menButton,
			womenButton
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
		didGenderChanged(to: .mix)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(callback: ((GameGenderType) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyGenderCell {

	func didGenderChanged(to type: GameGenderType) {
		mixButton.isSelected = type == .mix
		menButton.isSelected = type == .men
		womenButton.isSelected = type == .women
		callback?(type)
	}

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
		setupSeparator()
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

	func setupSeparator() {
		contentView.addSubviews(separator)
		NSLayoutConstraint.activate([
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

@available(iOS 17.0, *)
#Preview {
	NewGameOrTourneyAssembly.createModule(with: nil)
}
#endif
