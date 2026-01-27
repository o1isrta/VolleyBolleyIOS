//
//  PaywallPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol PaywallPresenterProtocol: AnyObject {
	var view: PaywallViewProtocol? { get set }
	var interactor: PaywallInteractorProtocol { get }
	var router: PaywallRouterProtocol { get }

	func viewDidLoad()
	func backButtonTapped()
	func privacyPublicButtonTapped()
	func privacyPrivateButtonTapped()
	func managePlayersButtonTapped()
	func addPaymentButtonTapped()
	func saveGameButtonTapped()
	func priceTextChanged(text: String?)
	func updatePlayersCount(to count: Int)
}

final class PaywallPresenter: PaywallPresenterProtocol {

	// MARK: - Public Properties

	weak var view: PaywallViewProtocol?
	let interactor: PaywallInteractorProtocol
	let router: PaywallRouterProtocol

	// MARK: - Private Properties

	private var isPublicGameSelected: Bool = true
	private var isPaymentSelected: Bool = false
	private var priceText: String?
	private var playersCount: Int = CounterType.players.minValue

	// MARK: - Initializers

	init(
		interactor: PaywallInteractorProtocol,
		router: PaywallRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		updateSaveButtonState()
		view?.updatePrivacyState(isPublic: isPublicGameSelected)
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func privacyPublicButtonTapped() {
		isPublicGameSelected = true
		view?.updatePrivacyState(isPublic: isPublicGameSelected)
	}

	func privacyPrivateButtonTapped() {
		isPublicGameSelected = false
		view?.updatePrivacyState(isPublic: isPublicGameSelected)
	}

	func managePlayersButtonTapped() {
		// TODO: -
		print("Открыть экран управления игроками")
	}

	func addPaymentButtonTapped() {
		// TODO: need to add payment account to profile
		guard let accountNumber = interactor.getAccountNumber() else {
			print("need to add payment account to profile")
			return
		}

		isPaymentSelected = true
		view?.updatePaymentSelection(isSelected: isPaymentSelected)
		view?.updatePlayersVisibility(isVisible: isPaymentSelected)
		view?.updateAccountInfo(accountNumber: accountNumber)
		view?.updatePaymentDescription(text: String(localized: "paywall.paymentRequirementDescription"))

		updateSaveButtonState()
	}

	func saveGameButtonTapped() {
		guard
			let priceText = priceText,
			!priceText.isEmpty,
			let price = Double(priceText),
			let accountNumber = interactor.getAccountNumber()
		else { return }

		interactor.saveGame(
			price: price,
			isPublic: isPublicGameSelected,
			playersCount: playersCount,
			accountNumber: accountNumber
		)
	}

	func priceTextChanged(text: String?) {
		priceText = text
		updateSaveButtonState()
	}

	func updatePlayersCount(to count: Int) {
		playersCount = count
	}

	// MARK: - Private Methods

	private func updateSaveButtonState() {
		let hasText = !(priceText?.isEmpty ?? true)
		view?.updateSaveButtonState(isEnabled: isPaymentSelected && hasText)
	}
}

// MARK: - PaywallInteractorOutputProtocol

extension PaywallPresenter: PaywallInteractorOutputProtocol {
	func gameSaved(success: Bool) {
		if success {
			print("Game Saved")
			// TODO: redirect to ...
			router.navigateBack()
		}
	}

	func accountNumberReceived(_ accountNumber: String) {
		view?.updateAccountInfo(accountNumber: accountNumber)
	}
}
