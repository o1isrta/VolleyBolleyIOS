//
//  RegistrationPlayerNameCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

enum RegistrationNameCellType {
	case name
	case surname

	var title: String {
		switch self {
		case .name: return String(localized: "Name")
		case .surname: return String(localized: "Surname")
		}
	}

	var isHasSeparator: Bool {
		switch self {
		case .name: return true
		case .surname: return false
		}
	}
}

final class RegistrationPlayerNameCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "RegistrationPlayerNameCell"

	// MARK: - Private Properties

	private var callback: ((String) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8
	}

	private let titleLabel = CustomLabel(text: "", isBold: true)

	private lazy var textField = {
		let textField = CustomTextField()
		textField.addAction(UIAction { [weak self] _ in
			self?.callback?(textField.text ?? "")
		}, for: .editingChanged)
		return textField
	}()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			titleLabel,
			textField,
			separator
		])
		stack.setCustomSpacing(Constants.inset, after: textField)
		stack.axis = .vertical
		stack.spacing = Constants.stackViewSpacing
		return stack
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

	func configure(
		type: RegistrationNameCellType,
		callback: ((String) -> Void)?
	) {
		titleLabel.text = type.title
		textField.placeholder = type.title
		separator.isHidden = type.isHasSeparator
		self.callback = callback
	}
}

// MARK: - Private Methods

private extension RegistrationPlayerNameCell {

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupViews()
	}

	func setupViews() {
		contentView.addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			mainStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),
			mainStackView.bottomAnchor.constraint(
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
			let cell = RegistrationPlayerNameCell(style: .default, reuseIdentifier: nil)
			cell.configure(type: .name) { text in
				print("name: \(text)")
				print("name length: \(text.count)")
			}
			return cell
		}
		.frame(maxHeight: 110)

		UIViewPreview {
			let cell = RegistrationPlayerNameCell(style: .default, reuseIdentifier: nil)
			cell.configure(type: .surname) { text in
				print("surname: \(text)")
				print("surname length: \(text.count)")
			}
			return cell
		}
		.frame(maxHeight: 110)
	}
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
