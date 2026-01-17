//
//  RegistrationPlayerBirthdayCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

final class RegistrationPlayerBirthdayCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "RegistrationPlayerBirthdayCell"

	// MARK: - Private Properties

	private var callback: ((String) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let birthdayTextFieldLeftPadding: CGFloat = 0
		static let birthdayTextFieldWidth: CGFloat = 120
		static let birthdayTextFieldValidCount: Int = 14
	}

	private let titleLabel = CustomLabel(text: String(localized: "Date of birth"), isBold: true)

	private lazy var birthdayTextField: CustomTextField = {
		let textField = CustomTextField(
			placeholder: "__ / __ / ____",
			alignment: .center,
			keyboardType: .numberPad,
			leftPadding: Constants.birthdayTextFieldLeftPadding
		)
		textField.delegate = self
		return textField
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

	func configure(callback: ((String) -> Void)?) {
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension RegistrationPlayerBirthdayCell {

	func validateDate() {
		guard birthdayTextField.text?.count == Constants.birthdayTextFieldValidCount
		else { return }
		callback?(birthdayTextField.text ?? "")
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
			birthdayTextField
		)
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			birthdayTextField.widthAnchor.constraint(equalToConstant: Constants.birthdayTextFieldWidth),
			birthdayTextField.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.insetMiddle
			),
			birthdayTextField.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			birthdayTextField.trailingAnchor.constraint(
				lessThanOrEqualTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			)
		])
	}

	func setupSeparator() {
		contentView.addSubviews(separator)
		NSLayoutConstraint.activate([
			separator.topAnchor.constraint(
				equalTo: birthdayTextField.bottomAnchor,
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

// MARK: - UITextFieldDelegate

extension RegistrationPlayerBirthdayCell: UITextFieldDelegate {

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		guard textField == birthdayTextField else {
			return true
		}
		let result = textField.updateFormattedText(
			range: range,
			replacementString: string,
			formatter: { $0.formattedBirthdayOrNil() }
		)
		validateDate()
		return result
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	VStack {
		UIViewPreview {
			let cell = RegistrationPlayerBirthdayCell(style: .default, reuseIdentifier: nil)
			cell.configure { date in
				print("date: \(date)")
				print("date length: \(date.count)")
			}
			return cell
		}
		.frame(maxHeight: 110)
	}
	.padding(.vertical)
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
