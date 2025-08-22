//
//  PaywallController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.08.2025.
//

import UIKit

final class PaywallController: BaseViewController {

	// MARK: - Private Properties

	private let mainSpacing: CGFloat = 20
	private let internalSpacing: CGFloat = 12

	private let glassmorphismView = GlassmorphismView()

	private lazy var privacyTitle = CustomTitle(text: String(localized: "paywall.privacyTitle"), isLarge: true)
	private lazy var privacyDescription = CustomLabel(text: String(localized: "paywall.privacyDescription"))

	private var isPublicButtonSelected: Bool = true
	private lazy var privacyPublicButton = PickButton(
		title: String(localized: "paywall.publicButton"),
		isSelected: isPublicButtonSelected,
		target: self,
		action: #selector(privacyPublicButtonTapped)
	)
	private lazy var privacyPrivateButton = PickButton(
		title: String(localized: "paywall.privateButton"),// TODO: -
		isSelected: !isPublicButtonSelected,
		target: self,
		action: #selector(privacyPrivateButtonTapped)
	)

	private lazy var privacyButtonsStackView: UIStackView = {
		let view = UIView()
		view.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		let stack = UIStackView(arrangedSubviews: [
			privacyPublicButton,
			privacyPrivateButton,
			view
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = 10
		stack.layoutMargins = UIEdgeInsets(top: internalSpacing, left: 0, bottom: 0, right: 0)
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var privacyStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			privacyTitle,
			privacyDescription,
			privacyButtonsStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .fill
		return stack
	}()

	private lazy var separator = CustomSeparator()

	private lazy var paymentTitle = CustomTitle(text: String(localized: "paywall.paymentTitle"), isLarge: true)
	private lazy var paymentDescription = CustomLabel(text: String(localized: "paywall.paymentDescription"))
	private lazy var paymentPerPerson = CustomLabel(text: String(localized: "paywall.paymentPerPerson"), isBold: true)
	private lazy var paymentPerPersonStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentPerPerson
			// TODO: - amount per person
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = 9
		stack.layoutMargins = UIEdgeInsets(top: internalSpacing, left: 0, bottom: 0, right: 0)
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var currentAccountLabel: UILabel = {
		let label = UILabel()
		label.text = String(localized: "paywall.currentAccountLabel")
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		return label
	}()
	private lazy var accountLabel: UILabel = {
		let label = UILabel()
		label.text = "988 016 7890"// TODO: - remove in the future
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.isHidden = true
		return label
	}()
	private lazy var addPaymentButton = PickButton(
		title: String(localized: "paywall.addPaymentButton"),
		isSelected: false,
		target: self,
		action: #selector(addPaymentButtonTapped)
	)
	private lazy var amountStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			currentAccountLabel,
			accountLabel,
			addPaymentButton
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
		stack.layoutMargins = UIEdgeInsets(top: internalSpacing, left: 0, bottom: 0, right: 0)
		stack.isLayoutMarginsRelativeArrangement = true
		return stack
	}()

	private lazy var paymentStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentTitle,
			paymentDescription,
			paymentPerPersonStackView,
			amountStackView
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		return stack
	}()

	private var isPaymentSelected: Bool = false
	private lazy var saveGameButton = NextStepButton(
		title: String(localized: "paywall.saveGameButton"),
		isActive: isPaymentSelected,
		target: self,
		action: #selector(saveGameButtonTapped)
	)

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			privacyStackView,
			separator,
			paymentStackView,
			saveGameButton
		])
		stack.axis = .vertical
		stack.spacing = mainSpacing
		return stack
	}()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
}

// MARK: - Private Methods

private extension PaywallController {

	func setupUI() {
		view.addSubviews(glassmorphismView)
		glassmorphismView.addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 1),

			amountStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
			amountStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),

			glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			glassmorphismView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			glassmorphismView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			glassmorphismView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: mainSpacing),

			mainStackView.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: mainSpacing),
			mainStackView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing),
			mainStackView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainSpacing)
		])
	}

	@objc func privacyPublicButtonTapped() {
		changePrivacyButtonState()
	}

	@objc func privacyPrivateButtonTapped() {
		changePrivacyButtonState()
	}

	func changePrivacyButtonState() {
		isPublicButtonSelected.toggle()
		privacyPublicButton.updateSelectionState(isPublicButtonSelected)
		privacyPrivateButton.updateSelectionState(!isPublicButtonSelected)
	}

	@objc func saveGameButtonTapped() {
		print("Save Game Button clicked")
	}

	@objc func addPaymentButtonTapped() {
		isPaymentSelected.toggle()
		addPaymentButton.isHidden = isPaymentSelected
		saveGameButton.setActive(isPaymentSelected)
		accountLabel.isHidden = !isPaymentSelected
	}
}

// MARK: - Preview

#if DEBUG
import SwiftUI

@available(iOS 17.0, *)
#Preview {
	UIViewControllerPreview {
		PaywallController()
	}
	.edgesIgnoringSafeArea(.all)
}
#endif
