//
//  NewGameOrTourneyPlaceCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

final class NewGameOrTourneyPlaceCell: UITableViewCell {

	// MARK: - Public Properties

	static let reuseIdentifier = "NewGameOrTourneyPlaceCell"

	// MARK: - Private Properties

	private var callback: (() -> Void)?

	private enum Constants {
		static let maxMessageLength: Int = 160

		static let inset: CGFloat = 16
		static let insetLitle: CGFloat = 8
		static let insetLarge: CGFloat = 20

		static let mainStackViewSpacing: CGFloat = 10

		static let viewHeight: CGFloat = 36

		static let titleFontSize: CGFloat = 20
		static let messageFontSize: CGFloat = 16
		static let counterFontSize: CGFloat = 14
	}

	private lazy var titleLabel: CustomLabel = {
		let label = CustomLabel(text: String(localized: "newGameOrTourney.place.title"), isBold: true)
		label.font = AppFont.ActayWide.bold(size: Constants.titleFontSize)
		label.textColor = AppColor.Text.primary
		label.backgroundColor = AppColor.Background.clear
		return label
	}()

	private lazy var locationTitleView: LocationTitleView = LocationTitleView(type: .icon)

	private lazy var placeButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "newGameOrTourney.place.change"), for: .normal)
		button.isSelected = true
		button.addAction(UIAction { [weak self] _ in
			self?.callback?()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			locationTitleView,
			placeButton
		])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = Constants.mainStackViewSpacing
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

	func configure(with model: LocationTitleViewModel, callback: (() -> Void)?) {
		locationTitleView.configure(with: model)
		self.callback = callback
	}
}

// MARK: - Private Properties

private extension NewGameOrTourneyPlaceCell {

	func setupUI() {
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none

		contentView.addSubviews(
			titleLabel,
			mainStackView,
			separator
		)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),

			mainStackView.topAnchor.constraint(
				equalTo: titleLabel.bottomAnchor,
				constant: Constants.insetLitle
			),
			mainStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.insetLarge
			),
			mainStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.insetLarge
			),

			locationTitleView.heightAnchor.constraint(equalToConstant: Constants.viewHeight),

			separator.topAnchor.constraint(
				equalTo: mainStackView.bottomAnchor,
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
	NewGameOrTourneyViewController()
}
#endif
