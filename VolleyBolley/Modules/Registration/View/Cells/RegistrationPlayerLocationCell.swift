//
//  RegistrationPlayerLocationCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

struct RegistrationPlayerLocationCellViewModel {
	let type: RegistrationLocationType
	let items: [String]
	let callback: ((String) -> Void)?
}

final class RegistrationPlayerLocationCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "RegistrationPlayerLocationCell"

	// MARK: - Private Properties

	private var callback: ((String) -> Void)?

	private enum Constants {
		static let inset: CGFloat = 16
		static let insetMiddle: CGFloat = 12
		static let insetLarge: CGFloat = 20

		static let stackViewSpacing: CGFloat = 8

		static let mainStackBottomConstraintPriority: Float = 999
	}

	private let titleLabel = CustomLabel(text: "", isBold: true)

	private lazy var locationPicker: LocationPickerView = {
		let list = LocationPickerView(items: [])
		list.delegate = self
		return list
	}()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			titleLabel,
			locationPicker,
			separator
		])
		stack.setCustomSpacing(Constants.inset, after: locationPicker)
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

	func configure(model: RegistrationPlayerLocationCellViewModel) {
		titleLabel.text = model.type.title
		locationPicker.placeholder = model.type.placeholder
		locationPicker.updateItems(model.items)
		separator.isHidden = model.type.isHasSeparator
		callback = model.callback
	}

	func invalidateCellHeight() {
		invalidateIntrinsicContentSize()
		setNeedsLayout()
		layoutIfNeeded()
	}
}

// MARK: - Private Methods

private extension RegistrationPlayerLocationCell {

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
			)
		])

		let bottomConstraint = mainStackView.bottomAnchor.constraint(
			equalTo: contentView.bottomAnchor,
			constant: -Constants.inset
		)
		bottomConstraint.priority = .init(Constants.mainStackBottomConstraintPriority)
		bottomConstraint.isActive = true
	}
}

// MARK: - LocationPickerViewDelegate

extension RegistrationPlayerLocationCell: LocationPickerViewDelegate {

	func locationPickerView(
		_ pickerView: LocationPickerView,
		didSelectItem item: String
	) {
		if pickerView == locationPicker {
			callback?(item)
		}
	}

	func locationPickerViewDidToggle(_ pickerView: LocationPickerView) {
		if pickerView == locationPicker {
			invalidateCellHeight()
		}
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI
@available(iOS 17.0, *)
#Preview {
	VStack {
		UIViewPreview {
			let cell = RegistrationPlayerLocationCell(style: .default, reuseIdentifier: nil)
			let items = ["Cyprus", "Thailand"]
			let model = RegistrationPlayerLocationCellViewModel(
				type: .country,
				items: items
			) { value in
				print("country: \(value)")
				print("country length: \(value.count)")
			}
			cell.configure(model: model)
			return cell
		}
		.frame(maxHeight: 110)

		UIViewPreview {
			let cell = RegistrationPlayerLocationCell(style: .default, reuseIdentifier: nil)
			let items = ["Koh Phangan", "Koh Samui"]
			let model = RegistrationPlayerLocationCellViewModel(
				type: .city,
				items: items
			) { value in
				print("city: \(value)")
				print("city length: \(value.count)")
			}
			cell.configure(model: model)
			return cell
		}
		.frame(maxHeight: 110)
	}
	.background(Color(uiColor: AppColor.Background.screen))
}
#endif
