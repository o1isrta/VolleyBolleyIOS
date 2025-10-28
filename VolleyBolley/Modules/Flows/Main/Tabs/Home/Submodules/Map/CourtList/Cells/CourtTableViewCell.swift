//
//  CourtTableViewCell.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import UIKit

final class CourtTableViewCell: UITableViewCell {

	// MARK: - Public Properties

	static var reuseIdentifier: String = "CourtTableViewCell"

	// MARK: - Private Properties

	private lazy var mainStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [locationTitleView, badgeView])
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 20
		return stackView
	}()

	private lazy var locationTitleView = LocationTitleView(type: .none)
	private lazy var badgeView = BadgeView()
	private lazy var separator = CustomSeparator()

	private lazy var noCourtsLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.text = String(localized: "No courts found")
		label.isHidden = true
		return label
	}()

	// MARK: - Initializers

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configureAsNoCourts() {
		noCourtsLabel.isHidden = false
		separator.isHidden = true
		locationTitleView.isHidden = true
		badgeView.isHidden = true
	}

	func configure(
		with court: CourtModel,
		distance: Double,
		isLast: Bool
	) {
		noCourtsLabel.isHidden = true
		locationTitleView.isHidden = false
		badgeView.isHidden = false

		let locationTitleViewModel = LocationTitleViewModel(
            title: court.location.courtName,
			location: court.location.locationName
		)
		locationTitleView.configure(with: locationTitleViewModel)

		let distanceText: String
		if distance >= 0 {
			distanceText = distance < 1
			? String(format: String(localized: "distance.meters"), distance * 1000)
			: String(format: String(localized: "distance.kilometers"), distance)
		} else {
			distanceText = "—"
		}

		badgeView.configure(distance: distanceText)
		separator.isHidden = isLast
	}
}

// MARK: - Private Methods

private extension CourtTableViewCell {

	func setupUI() {
		selectionStyle = .none
		backgroundColor = .clear

		contentView.addSubviews(mainStackView, noCourtsLabel, separator)

		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
			mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

			mainStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),
			locationTitleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 36),

			noCourtsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -6),
			noCourtsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			noCourtsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

			separator.heightAnchor.constraint(equalToConstant: 1),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
		])
	}
}
