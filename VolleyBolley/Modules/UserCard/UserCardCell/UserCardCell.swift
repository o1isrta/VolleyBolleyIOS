//
//  UserCardCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 09.11.2025.
//

import UIKit

final class UserCardCell: UITableViewCell {

	// MARK: - Constants

	static let reuseIdentifier = "UserCardCell"

	private enum Constants {
		static let cellHeight: CGFloat = 103

		static let horizontalInset: CGFloat = 16
		static let verticalInset: CGFloat = 8

		static let fontSize: CGFloat = 16

		static let locationStackHeight: CGFloat = 44
		static let locationStackSpacing: CGFloat = 10
		static let glassmorphismViewAlpha: CGFloat = 0.7
	}

	// MARK: - Private Properties

	private var mapButtonCallback: (() -> Void)?

	private lazy var glassmorphismView = {
		let view = GlassmorphismView(configuration: .message)
		view.alpha = Constants.glassmorphismViewAlpha
		return view
	}()

	private lazy var dateLabel: CustomLabel = {
		let label = CustomLabel(text: "", isBold: false)
		label.font = AppFont.Hero.regular(size: Constants.fontSize)
		return label
	}()

	private lazy var locationTitleView: LocationTitleView = LocationTitleView(type: .icon)

	private lazy var mapButton: OrangeButton = {
		let button = OrangeButton(style: .large)
		button.setTitle(String(localized: "Map"), for: .normal)
		button.addAction(UIAction { [weak self] _ in
			self?.mapButtonCallback?()
		}, for: .touchUpInside)
		return button
	}()

	private lazy var locationStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			locationTitleView,
			mapButton
		])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.spacing = Constants.locationStackSpacing
		return stackView
	}()

	// MARK: - Init

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = AppColor.Background.clear
		selectionStyle = .none
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(with model: UserCardCellViewModel) {
		glassmorphismView.resetForReuse()
		dateLabel.text = model.date
		locationTitleView.configure(with: model.location)
		mapButtonCallback = model.mapButtonCallback
	}
}

// MARK: - Private Methods

private extension UserCardCell {

	func setupView() {
		contentView.addSubviews(
			glassmorphismView,
			dateLabel,
			locationStackView
		)
		setupConstraints()
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.verticalInset
			),
			glassmorphismView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			glassmorphismView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			glassmorphismView.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.verticalInset
			),

			dateLabel.topAnchor.constraint(
				equalTo: glassmorphismView.topAnchor,
				constant: Constants.verticalInset
			),
			dateLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			dateLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),

			locationStackView.topAnchor.constraint(
				equalTo: dateLabel.bottomAnchor,
				constant: Constants.verticalInset
			),
			locationStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.horizontalInset
			),
			locationStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.horizontalInset
			),
			locationStackView.bottomAnchor.constraint(
				equalTo: glassmorphismView.bottomAnchor,
				constant: -Constants.verticalInset
			),
			locationStackView.heightAnchor.constraint(
				equalToConstant: Constants.locationStackHeight
			),

			contentView.heightAnchor.constraint(
				equalToConstant: Constants.cellHeight
			)
		])
	}
}

#if DEBUG

// MARK: - Preview

import SwiftUI

@available(iOS 17.0, *)
#Preview {
	ZStack {
		Color(uiColor: AppColor.Background.screen)
			.ignoresSafeArea()
		UIViewPreview {
			let view = UserCardCell()

			let court = CourtModel.mockData
			let locationModel = LocationTitleViewModel(
				title: court.location.courtName,
				location: court.location.locationName
			)
			let model = UserCardCellViewModel(
				date: Date(),
				location: locationModel
			) {
				print("open map at location:", court.location.latitude, court.location.longitude)
			}
			view.configure(with: model)
			return view
		}
		.frame(width: 336, height: 103)
	}
}

#endif
