//
//  RegistrationPlayerGenderCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

final class RegistrationPlayerGenderCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "RegistrationPlayerGenderCell"

	// MARK: - Private Properties

	private var callback: ((RegistrationGenderType) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8
	}

	private let titleLabel = CustomLabel(text: String(localized: "gender.title"), isBold: true)

	private lazy var maleButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "gender.male"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didGenderChanged(to: .male)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var femaleButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "gender.female"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.didGenderChanged(to: .female)
		}, for: .touchUpInside)
		return button
	}()

	private lazy var stackView: UIStackView = {
		maleButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		femaleButton.setContentCompressionResistancePriority(.required, for: .horizontal)
		maleButton.setContentHuggingPriority(.required, for: .horizontal)
		femaleButton.setContentHuggingPriority(.required, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			maleButton,
			femaleButton
		])
		stackView.axis = .horizontal
		stackView.alignment = .center
		stackView.spacing = Constants.stackViewSpacing
		return stackView
	}()

	private let separator = CustomSeparator()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(callback: ((RegistrationGenderType) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension RegistrationPlayerGenderCell {

	func didGenderChanged(to type: RegistrationGenderType) {
		maleButton.isSelected = type == .male
		femaleButton.isSelected = type == .female
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
				constant: Constants.insetMiddle
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

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	VStack {
		UIViewPreview {
			let cell = RegistrationPlayerGenderCell(style: .default, reuseIdentifier: nil)
			return cell
		}
		.frame(maxHeight: 110)
	}
	.padding(.vertical)
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
