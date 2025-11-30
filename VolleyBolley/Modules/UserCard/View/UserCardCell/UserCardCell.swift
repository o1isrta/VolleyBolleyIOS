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
        let view = GlassView(config: .note)
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

	private lazy var noActivityLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = String(localized: "userCard.noActivity")
		label.isHidden = true
		return label
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
		hasCourtData(true)

		dateLabel.text = model.date
		locationTitleView.configure(with: model.location)
		mapButtonCallback = model.mapButtonCallback
	}

	func configureAsNoActivity() {
		hasCourtData(false)
	}
}

// MARK: - Private Methods

private extension UserCardCell {

	func hasCourtData(_ isHidden: Bool) {
		let shownViews = [
			glassmorphismView,
			dateLabel,
			locationTitleView,
			mapButton
		]
		let hiddenViews = [noActivityLabel]

		shownViews.forEach { $0.isHidden = !isHidden }
		hiddenViews.forEach { $0.isHidden = isHidden }
	}

	func setupView() {
		contentView.addSubviews(
			glassmorphismView,
			dateLabel,
			locationStackView,
			noActivityLabel
		)
		setupConstraints()
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			noActivityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			noActivityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

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

		VStack {
			UIViewPreview {
				let view = UserCardCell()

				let court = CourtModel.mockData
				let locationModel = LocationTitleViewModel(
					title: court.location.courtName,
					location: court.location.locationName
				)
				let model = UserCardCellViewModel(
					dateString: AppDateFormatters.iso8601.string(from: Date()),
					location: locationModel
				) {
					print("open map at location:", court.location.latitude, court.location.longitude)
				}
				view.configure(with: model)
				return view
			}
			.frame(width: 336, height: 103)

			UIViewPreview {
				let view = UserCardCell()
				view.configureAsNoActivity()
				return view
			}
			.frame(width: 336, height: 103)
		}
	}
}

#endif
