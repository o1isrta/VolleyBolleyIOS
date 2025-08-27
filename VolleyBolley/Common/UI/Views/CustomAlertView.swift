//
//  CustomAlertView.swift
//  VolleyBolley
//
//  Created by Вадим on 15.07.2025.
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

	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel, buttonStack])
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

	func configure(with model: CustomAlertModel) {
		messageLabel.text = model.message
		primaryButton.setTitle(model.primaryButton.title, for: .normal)
		primaryAction = model.primaryButton.action
		secondaryButton.isHidden = true

		if let title = model.title {
			titleLabel.text = title
			titleLabel.isHidden = false
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
			title: "Notifications",
			message: "Stay in the loop on games and invites!",
			primaryButton: ButtonDataModel(
				title: "ENABLE",
				action: { print("ENABLE") }
			),
			secondaryButton: ButtonDataModel(
				title: "SKIP",
				action: { print("SKIP") }
			)
		)
		view.configure(with: model)
		return view
	}
	.ignoresSafeArea()
}

#Preview("Exit") {
	UIViewPreview {
		let view = CustomAlertView()
		let model = CustomAlertModel(
			message: "Are you sure you want to log out of your account?",
			primaryButton: ButtonDataModel(
				title: "NO",
				action: { print("NO") }
			),
			secondaryButton: ButtonDataModel(
				title: "YES",
				action: { print("YES") }
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
			message: "Invites have been successfully sent to players!",
			primaryButton: ButtonDataModel(
				title: "DONE",
				action: { print("DONE") }
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
				title: "RATE PLAYERS",
				action: { print("RATE PLAYERS") }
			),
			secondaryButton: ButtonDataModel(
				title: "SKIP",
				action: { print("SKIP") }
			)
		)
		view.configure(with: model)
		return view
	}
	.ignoresSafeArea()
}
#endif
