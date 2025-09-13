//
//  DistanceView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.08.2025.
//

import UIKit

final class DistanceView: UIView {

	// MARK: - Private Properties

	private lazy var distanceLabel: UILabel = {
		let label = UILabel()
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.textAlignment = .center
		return label
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(distance: String) {
		distanceLabel.text = distance
	}
}

// MARK: - Private Methods

private extension DistanceView {

	func setupUI() {
		backgroundColor = AppColor.Background.badgeDefault
		layer.cornerRadius = 10

		addSubviews(distanceLabel)

		NSLayoutConstraint.activate([
			distanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
			distanceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
		])
	}
}
