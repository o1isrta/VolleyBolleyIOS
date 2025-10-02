//
//  PaywallController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.08.2025.
//

import UIKit

protocol PaywallViewProtocol: AnyObject {
	var presenter: PaywallPresenterProtocol? { get set }

	func updateSaveButtonState(isEnabled: Bool)
	func updatePaymentSelection(isSelected: Bool)
	func updatePrivacyState(isPublic: Bool)
	func updatePlayersVisibility(isVisible: Bool)
	func updateAccountInfo(accountNumber: String)
	func updatePaymentDescription(text: String)
}

final class PaywallViewController: BaseViewController {

	// MARK: - Public Properties

	var presenter: PaywallPresenterProtocol?

	// MARK: - Private Properties

	private let mainSpacing: CGFloat = 20
	private let internalSpacing: CGFloat = 12

	private let glassmorphismView = GlassmorphismView()

	private lazy var screenTitle = CustomTitle(text: String(localized: "paywall.screenTitle"), isLarge: true)
	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var playersTitle = CustomTitle(text: String(localized: "paywall.playersTitle"), isLarge: true)
	private lazy var playersCounter = CounterView(type: .players)
	private lazy var playersStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			playersTitle,
			playersCounter
		])
		stack.axis = .vertical
		stack.distribution = .fill
		stack.alignment = .leading
		stack.spacing = internalSpacing
		stack.isHidden = true
		return stack
	}()

	private lazy var privacyTitle = CustomTitle(text: String(localized: "paywall.privacyTitle"), isLarge: true)
	private lazy var privacyDescription = CustomLabel(text: String(localized: "paywall.privacyDescription"))

	private lazy var privacyPublicButton: GreenButton = {
		let button = GreenButton()
		button.setTitle(String(localized: "paywall.publicButton"), for: .normal)
		button.addTarget(self, action: #selector(privacyPublicButtonTapped), for: .touchUpInside)
		return button
	}()
	private lazy var privacyPrivateButton: GreenButton = {
		let button = GreenButton(imagePlacement: .trailing)
		button.setTitle(String(localized: "paywall.privateButton"), for: .normal)
		button.setImage(.arrowForward, for: .normal)
		button.addTarget(self, action: #selector(privacyPrivateButtonTapped), for: .touchUpInside)
		return button
	}()

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
	private lazy var priceView: PriceView = {
		let priceView = PriceView()
		priceView.text = "5"
		priceView.isUserInteractionEnabled = false
		priceView.onTextChanged = { [weak self] text in
			self?.presenter?.priceTextChanged(text: text)
		}
		return priceView
	}()
	private lazy var paymentPerPersonStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			paymentPerPerson,
			priceView
		])
		stack.axis = .horizontal
		stack.distribution = .fill
		stack.alignment = .center
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
		label.font = AppFont.Hero.regular(size: 16)
		label.textColor = AppColor.Text.primary
		label.isHidden = true
		return label
	}()
	private lazy var addPaymentButton: GreenButton = {
		let button = GreenButton()
		button.isSelected = false
		button.setTitle(String(localized: "paywall.addPaymentButton"), for: .normal)
		button.addTarget(self, action: #selector(addPaymentButtonTapped), for: .touchUpInside)
		return button
	}()
	private lazy var amountStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			currentAccountLabel,
			accountLabel,
			addPaymentButton
		])
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
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

	private lazy var saveGameButton: YellowButton = {
		let button = YellowButton()
		button.isEnabled = false
		button.isSelected = true
		button.setTitle(String(localized: "paywall.saveGameButton"), for: .normal)
		button.addTarget(self, action: #selector(saveGameButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var mainStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			playersStackView,
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
		presenter?.viewDidLoad()
		hideKeyboardWhenTappedAround()
	}
}

// MARK: - Private Methods

private extension PaywallViewController {

	func setupUI() {
		view.addSubviews(
			glassmorphismView,
			screenTitle,
			backButton
		)
		glassmorphismView.addSubviews(mainStackView)

		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 1),

			backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: 14),
			backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
			screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: mainSpacing),

			playersCounter.heightAnchor.constraint(equalToConstant: 39),

			amountStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
			amountStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
			amountStackView.heightAnchor.constraint(equalToConstant: 52),

			priceView.heightAnchor.constraint(equalToConstant: 30),
			priceView.widthAnchor.constraint(equalToConstant: 75),

			saveGameButton.heightAnchor.constraint(equalToConstant: 44),

			glassmorphismView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 8),
			glassmorphismView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			glassmorphismView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			glassmorphismView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: mainSpacing),

			mainStackView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: mainSpacing),
			mainStackView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing),
			mainStackView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainSpacing)
		])
	}

	@objc func backButtonTapped() {
		presenter?.backButtonTapped()
	}

	@objc func privacyPublicButtonTapped() {
		presenter?.privacyPublicButtonTapped()
	}

	@objc func privacyPrivateButtonTapped() {
		presenter?.privacyPrivateButtonTapped()
	}

	@objc func saveGameButtonTapped() {
		presenter?.updatePlayersCount(to: playersCounter.value)
		presenter?.saveGameButtonTapped()
	}

	@objc func addPaymentButtonTapped() {
		presenter?.addPaymentButtonTapped()
	}
}

// MARK: - PaywallViewProtocol

extension PaywallViewController: PaywallViewProtocol {

	func updateSaveButtonState(isEnabled: Bool) {
		saveGameButton.isEnabled = isEnabled
	}

	func updatePaymentSelection(isSelected: Bool) {
		addPaymentButton.isHidden = isSelected
		accountLabel.isHidden = !isSelected
		priceView.isUserInteractionEnabled = isSelected
		priceView.becomeActive()
	}

	func updatePrivacyState(isPublic: Bool) {
		privacyPublicButton.isSelected = isPublic
		privacyPrivateButton.isSelected = !isPublic
	}

	func updatePlayersVisibility(isVisible: Bool) {
		playersStackView.isHidden = !isVisible
	}

	func updateAccountInfo(accountNumber: String) {
		accountLabel.text = accountNumber
	}

	func updatePaymentDescription(text: String) {
		paymentDescription.text = text
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	PaywallViewController()
}
#endif
