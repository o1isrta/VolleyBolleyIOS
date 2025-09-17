//
//  NotificationImageView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.09.2025.
//

import UIKit

// MARK: - NotificationButtonDelegate

protocol NotificationButtonDelegate: AnyObject {
	func notificationButtonDidTap()
}

final class NotificationButtonView: UIView {

	// MARK: - Public Properties

	weak var delegate: NotificationButtonDelegate?

	// MARK: - Private Properties

	private var isNewNotifications: Bool = false

	private lazy var notificationButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.tintColor = AppColor.Background.primary

		if let baseConfig = button.configuration?.preferredSymbolConfigurationForImage {
			let highlightedConfig = baseConfig.applying(
				UIImage.SymbolConfiguration(paletteColors: [
					AppColor.Icon.bellBadge
				])
			)
			button.setPreferredSymbolConfiguration(highlightedConfig, forImageIn: .highlighted)
		}

		button.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
		return button
	}()

	// MARK: - Initializers

	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupUI()
		hasNewNotifications(isNewNotifications)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) { nil }

	// MARK: - Public Methods

	func hasNewNotifications(_ newNotifications: Bool) {
		isNewNotifications = newNotifications

		guard let baseConfig = notificationButton
			.configuration?.preferredSymbolConfigurationForImage
		else { return }

		switch isNewNotifications {
		case true:
			notificationButton.setImage(.bellBadge, for: .normal)
			let normalConfig = baseConfig.applying(
				UIImage.SymbolConfiguration(paletteColors: [AppColor.Icon.bellBadge, AppColor.Icon.primary])
			)
			notificationButton.setPreferredSymbolConfiguration(normalConfig, forImageIn: .normal)
		case false:
			notificationButton.setImage(.bell, for: .normal)
			let normalConfig = baseConfig.applying(
				UIImage.SymbolConfiguration(paletteColors: [
					AppColor.Icon.primary
				])
			)
			notificationButton.setPreferredSymbolConfiguration(normalConfig, forImageIn: .normal)
		}
	}
}

// MARK: - Private Methods

private extension NotificationButtonView {

	@objc func notificationButtonTapped() {
		// Always notify delegate about the tap for navigation
		delegate?.notificationButtonDidTap()
		// Clear notification badge if there were new notifications
		if isNewNotifications {
			isNewNotifications.toggle()
			hasNewNotifications(isNewNotifications)
		}
	}

	func setupUI() {
		addSubviews(notificationButton)

		NSLayoutConstraint.activate([
			notificationButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			notificationButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			notificationButton.topAnchor.constraint(equalTo: topAnchor),
			notificationButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview {
	HStack {
		UIViewPreview {
			let view = NotificationButtonView()
			view.hasNewNotifications(true)
			return view
		}

		UIViewPreview {
			let view = NotificationButtonView()
			return view
		}
	}
	.frame(width: 120, height: 68)
	.background(Color(cgColor: AppColor.Background.screen.cgColor))
	.padding()
}
#endif
