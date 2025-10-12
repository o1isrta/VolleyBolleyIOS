//
//  BadgeView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.08.2025.
//

import UIKit

final class BadgeView: UIView {

	// MARK: - Private Properties

	private let configuration: BadgeViewConfiguration

	enum BadgeViewConfiguration {
		case standard
		case highlighted

		var font: UIFont {
			switch self {
			case .standard:
				return AppFont.Hero.regular(size: 16)
			case .highlighted:
				return AppFont.Hero.bold(size: 16)
			}
		}

		var textColor: UIColor {
			switch self {
			case .standard:
				return AppColor.Text.primary
			case .highlighted:
				return AppColor.Text.inverted
			}
		}

		var backgroundColor: UIColor {
			switch self {
			case .standard:
				return AppColor.Background.badgeDefault
			case .highlighted:
				return AppColor.Background.badgeHighlighted
			}
		}
	}

	private lazy var distanceLabel: UILabel = {
		let label = UILabel()
		label.font = configuration.font
		label.textColor = configuration.textColor
		label.textAlignment = .center
		return label
	}()

	// MARK: - Initializers

	init(configuration: BadgeViewConfiguration = .standard) {
		self.configuration = configuration
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func configure(distance: String) {
		distanceLabel.text = distance
	}
}

// MARK: - Private Methods

private extension BadgeView {

	func setupUI() {
		backgroundColor = configuration.backgroundColor
		layer.cornerRadius = 10

		addSubviews(distanceLabel)

		NSLayoutConstraint.activate([
			distanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
		])
	}
}
