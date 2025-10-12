//
//  MyGamesCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import UIKit

final class MyGamesCell: UITableViewCell {

	// MARK: - Constants

	static let reuseIdentifier = "MyGamesCell"

	private enum Constants {
		static let horizontalInset: CGFloat = 20
		static let verticalInset: CGFloat = 12
		static let minHeight: CGFloat = 59

		static let titleFontSize: CGFloat = 16
		static let descriptionFontSize: CGFloat = 16
		static let textSpacing: CGFloat = 12
	}

	// MARK: - Private Properties

	private let titleLabel: CustomLabel = {
		let label = CustomLabel(text: "", isBold: false)
		label.font = AppFont.Hero.regular(size: Constants.titleFontSize)
		return label
	}()

	private let descriptionLabel: CustomLabel = {
		let label = CustomLabel(text: "", isBold: false)
		label.font = AppFont.Hero.light(size: Constants.descriptionFontSize)
		return label
	}()

	private lazy var titleStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			titleLabel,
			descriptionLabel
		])
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .leading
		return stackView
	}()

	private lazy var badgeView: BadgeView = {
		let view = BadgeView(configuration: .highlighted)
		view.isHidden = true
		return view
	}()

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			titleStackView,
			badgeView
		])
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.alignment = .center
		stackView.spacing = Constants.textSpacing
		return stackView
	}()

	private lazy var separatorLine = CustomSeparator()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	override func prepareForReuse() {
		super.prepareForReuse()
		titleLabel.text = nil
		descriptionLabel.text = nil
		separatorLine.isHidden = true
		badgeView.isHidden = true
	}

	func configure(with model: MyGamesViewItem, isLast: Bool = false) {
		titleLabel.text = model.title
		descriptionLabel.text = model.description

		if let badge = model.badge {
			badgeView.configure(distance: badge)
			badgeView.isHidden = badge.isEmpty
		}

		separatorLine.isHidden = isLast
	}
}

// MARK: - Private Methods

private extension MyGamesCell {

	func setupView() {
		contentView.addSubviews(
			mainStackView,
			separatorLine
		)
		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.verticalInset
			),
			mainStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			mainStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),

			separatorLine.topAnchor.constraint(
				equalTo: mainStackView.bottomAnchor,
				constant: Constants.verticalInset
			),
			separatorLine.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			separatorLine.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),
			separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			contentView.heightAnchor.constraint(
				greaterThanOrEqualToConstant: Constants.minHeight
			)
		])
	}
}
