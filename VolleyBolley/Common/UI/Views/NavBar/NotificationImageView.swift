//
//  NotificationImageView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.09.2025.
//

import UIKit

final class NotificationImageView: UIView {

	// MARK: - Private Properties

	private lazy var notificationImageView: UIImageView = {
		let imageView = UIImageView(image: .bell)
		imageView.tintColor = AppColor.Icon.primary
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
		hasNewNotifications(false)
	}

	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func hasNewNotifications(_ newNotifications: Bool) {
		switch newNotifications {
		case true:
			let config = UIImage.SymbolConfiguration(
				hierarchicalColor: AppColor.Icon.bellBadge
			).applying(
				UIImage.SymbolConfiguration(
						paletteColors: [
							AppColor.Icon.bellBadge,
							AppColor.Icon.primary
						]
					)
			)
			notificationImageView.image = .bellBadge?.withConfiguration(config)
		case false:
			notificationImageView.image = .bell
			notificationImageView.tintColor = AppColor.Icon.primary
		}
	}
}

// MARK: - Private Methods

private extension NotificationImageView {

	func setupUI() {
		addSubviews(notificationImageView)

		NSLayoutConstraint.activate([
			notificationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			notificationImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			notificationImageView.topAnchor.constraint(equalTo: topAnchor),
			notificationImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}
