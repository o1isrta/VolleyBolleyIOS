//
//  CustomAlertView.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 27.08.2025.
//

import UIKit

struct CustomAlertModel {
	let title: String?
	let message: String
	let primaryButton: ButtonDataModel
	let secondaryButton: ButtonDataModel?

	init(
		message: String,
		primaryButton: ButtonDataModel,
		secondaryButton: ButtonDataModel? = nil
	) {
		self.title = nil
		self.message = message
		self.primaryButton = primaryButton
		self.secondaryButton = secondaryButton
	}

	init(
		title: String,
		message: String,
		primaryButton: ButtonDataModel,
		secondaryButton: ButtonDataModel? = nil
	) {
		self.title = title
		self.message = message
		self.primaryButton = primaryButton
		self.secondaryButton = secondaryButton
	}
}

final class CustomAlertView: UIView {

	enum AlertType {
		case notification
		case general
	}

	// MARK: - Private Properties

	private var primaryAction: (() -> Void)?
	private var secondaryAction: (() -> Void)?

	private lazy var backgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = AppEffect.BackgroundAlert.alert
		return view
	}()

	private lazy var customViewAlert: UIView = {
		let view = UIView()
		view.backgroundColor = AppColor.Background.modal
		view.layer.cornerRadius = 32
		return view
	}()

	private lazy var titleLabel: CustomTitle = {
		let label = CustomTitle(text: "", isLarge: true)
		label.textAlignment = .center
		label.isHidden = true
		return label
	}()

	private lazy var messageLabel: CustomLabel = {
		let label = CustomLabel(text: "", isBold: true)
		label.textAlignment = .center
		return label
	}()

	private lazy var primaryButton: YellowButton = {
		let button = YellowButton()
		button.isSelected = true
		button.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var secondaryButton: YellowButton = {
		let button = YellowButton()
		button.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var buttonStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [secondaryButton, primaryButton])
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 7
		return stack
	}()

	private lazy var notificationOpportunitiesStack: UIStackView = {
		let stack = UIStackView()
		stack.isHidden = true
		stack.axis = .vertical
		return stack
	}()

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(
			arrangedSubviews: [
				titleLabel,
				messageLabel,
				notificationOpportunitiesStack,
				buttonStack
			]
		)
		stack.axis = .vertical
		stack.spacing = 12
		return stack
	}()

	// MARK: - Initializer

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public Methods

	func configure(with model: CustomAlertModel, for alertType: AlertType = .general) {
		messageLabel.text = model.message
		primaryButton.setTitle(model.primaryButton.title, for: .normal)
		primaryAction = model.primaryButton.action

		secondaryButton.isHidden = true
		titleLabel.isHidden = true
		messageLabel.textAlignment = .center
		notificationOpportunitiesStack.isHidden = true

		if let title = model.title {
			titleLabel.text = title
			titleLabel.isHidden = false
		}

		if alertType == .notification {
			configureAsNotification()
		}

		if let secondaryButtonData = model.secondaryButton {
			secondaryButton.isHidden = false
			secondaryButton.setTitle(secondaryButtonData.title, for: .normal)
			secondaryAction = secondaryButtonData.action
		}
	}
}

// MARK: - Private Method

private extension CustomAlertView {

	func configureAsNotification() {
		messageLabel.textAlignment = .justified
		notificationOpportunitiesStack.isHidden = false
		[
			String(localized: "customAlertView.notificationOpportunities.achievements"),
			String(localized: "customAlertView.notificationOpportunities.reminders"),
			String(localized: "customAlertView.notificationOpportunities.ratings")
		].forEach {
			let label = CustomLabel(text: "• \($0)", isBold: true)
			notificationOpportunitiesStack.addArrangedSubview(label)
		}
	}

	@objc func primaryButtonTapped() {
		primaryAction?()
	}

	@objc func secondaryButtonTapped() {
		secondaryAction?()
	}

	func setupUI() {
		addSubviews(
			backgroundView,
			customViewAlert
		)
		customViewAlert.addSubviews(mainStack)

		NSLayoutConstraint.activate([
			backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundView.topAnchor.constraint(equalTo: topAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

			customViewAlert.centerXAnchor.constraint(equalTo: centerXAnchor),
			customViewAlert.centerYAnchor.constraint(equalTo: centerYAnchor),
			customViewAlert.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			customViewAlert.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

			mainStack.topAnchor.constraint(equalTo: customViewAlert.topAnchor, constant: 20),
			mainStack.leadingAnchor.constraint(equalTo: customViewAlert.leadingAnchor, constant: 20),
			mainStack.trailingAnchor.constraint(equalTo: customViewAlert.trailingAnchor, constant: -20),
			mainStack.bottomAnchor.constraint(equalTo: customViewAlert.bottomAnchor, constant: -20),

			buttonStack.heightAnchor.constraint(equalToConstant: 44)
		])
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI
@available(iOS 17.0, *)
#Preview("Notifications") {
	UIViewPreview {
		let view = CustomAlertView()
		let model = CustomAlertModel(
			title: String(localized: "customAlertView.title.notification"),
			message: String(localized: "customAlertView.message.notification"),
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.enable"),
				action: { print(String(localized: "customAlertView.button.enable")) }
			),
			secondaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.skip"),
				action: { print(String(localized: "customAlertView.button.skip")) }
			)
		)
		view.configure(with: model, for: .notification)
		return view
	}
	.ignoresSafeArea()
}

#Preview("Exit") {
	UIViewPreview {
		let view = CustomAlertView()
		let model = CustomAlertModel(
			message: String(localized: "customAlertView.message.logout"),
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.no"),
				action: { print(String(localized: "customAlertView.button.no")) }
			),
			secondaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.yes"),
				action: { print(String(localized: "customAlertView.button.yes")) }
			)
		)
		view.configure(with: model)
		return view
	}
	.ignoresSafeArea()
}

#Preview("Invite") {
	UIViewPreview {
		let view = CustomAlertView()
		let model = CustomAlertModel(
			message: String(localized: "customAlertView.message.invitesSent"),
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.done"),
				action: { print(String(localized: "customAlertView.button.done")) }
			)
		)
		view.configure(with: model)
		return view
	}
	.ignoresSafeArea()
}

#Preview("Rating") {
	UIViewPreview {
		let view = CustomAlertView()
		let model = CustomAlertModel(
			message: "The game on October 6 has ended. Would you like to rate the players?",
			primaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.rate"),
				action: { print(String(localized: "customAlertView.button.rate")) }
			),
			secondaryButton: ButtonDataModel(
				title: String(localized: "customAlertView.button.skip"),
				action: { print(String(localized: "customAlertView.button.skip")) }
			)
		)
		view.configure(with: model)
		return view
	}
	.ignoresSafeArea()
}
#endif
