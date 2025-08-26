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

	private lazy var screenTitle = CustomTitle(text: String(localized: "paywall.screenTitle"), isLarge: true)
	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var privacyTitle = CustomTitle(text: String(localized: "paywall.privacyTitle"), isLarge: true)
	private lazy var privacyDescription = CustomLabel(text: String(localized: "paywall.privacyDescription"))

	private var isPublicGameSelected: Bool = true
	private lazy var privacyPublicButton: GreenButton = {
		let button = GreenButton()
		button.isSelected = isPublicGameSelected
		button.setTitle(String(localized: "paywall.publicButton"), for: .normal)
		button.addTarget(self, action: #selector(privacyPublicButtonTapped), for: .touchUpInside)
		return button
	}()
	private lazy var privacyPrivateButton: GreenButton = {
		let button = GreenButton(imagePlacement: .trailing)
		button.isSelected = !isPublicGameSelected
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

	private var isPaymentSelected: Bool = false
	private lazy var saveGameButton: YellowButton = {
		let button = YellowButton()
		button.isEnabled = isPaymentSelected
		button.isSelected = true
		button.setTitle(String(localized: "paywall.saveGameButton"), for: .normal)
		button.addTarget(self, action: #selector(saveGameButtonTapped), for: .touchUpInside)
		return button
	}()

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
		setupGesture()
	}
}

// MARK: - Private Methods

private extension PaywallController {

	func setupGesture() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
		view.addGestureRecognizer(tapGesture)
	}

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

			amountStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
			amountStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
			amountStackView.heightAnchor.constraint(equalToConstant: 52),

			priceView.heightAnchor.constraint(equalToConstant: 30),
			priceView.widthAnchor.constraint(equalToConstant: 75),

			saveGameButton.heightAnchor.constraint(equalToConstant: 44),

			glassmorphismView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			glassmorphismView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
			glassmorphismView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
			glassmorphismView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: mainSpacing),

			mainStackView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: mainSpacing),
			mainStackView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing),
			mainStackView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainSpacing)
		])
	}

	@objc func backButtonTapped() {
		print("Back Button clicked")
	}

	@objc func privacyPublicButtonTapped() {
		changePrivacyButtonState()
	}

	@objc func privacyPrivateButtonTapped() {
		changePrivacyButtonState()
	}

	func changePrivacyButtonState() {
		isPublicGameSelected.toggle()
		privacyPublicButton.isSelected = isPublicGameSelected
		privacyPrivateButton.isSelected = !isPublicGameSelected
	}

	@objc func handleTapOutside(_ gesture: UITapGestureRecognizer) {
		if !priceView.frame.contains(gesture.location(in: view)) {
			priceView.resignActive()
		}
	}

	@objc func saveGameButtonTapped() {
		// TODO: adding alert for empty price value

		print("Save Game Button clicked")
		print("Price: \(priceView.text ?? "")")
		print("Price Double: \(String(describing: priceView.getNumericValue()))")
		print("Account: \(String(describing: accountLabel.text))")
		print("Public game: \(isPublicGameSelected)")
	}

	@objc func addPaymentButtonTapped() {
		isPaymentSelected.toggle()
		saveGameButton.isEnabled = isPaymentSelected
		addPaymentButton.isHidden = isPaymentSelected
		accountLabel.isHidden = !isPaymentSelected

		priceView.isUserInteractionEnabled = isPaymentSelected
		priceView.becomeActive()

		paymentDescription.text = String(localized: "paywall.paymentRequirementDescription")

		accountLabel.text = "988 016 7890"// TODO: - remove in the future
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	PaywallController()
}
#endif
