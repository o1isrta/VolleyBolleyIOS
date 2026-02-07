//
//  CreateTourneyPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.02.2026.
//

import UIKit

protocol CreateTourneyPresenterProtocol: AnyObject {
	var view: CreateTourneyViewProtocol? { get set }
	var interactor: CreateTourneyInteractorProtocol { get }
	var router: CreateTourneyRouterProtocol { get }

	func viewDidLoad()
	func backButtonTapped()
	func updateGamePrivacyState(isPublic: Bool)
	func addPaymentButtonTapped()
	func saveTourneyButtonTapped()
	func priceChangedTo(value: String?)
	func updatePlayersCount(to count: Int)
}

final class CreateTourneyPresenter: CreateTourneyPresenterProtocol {

	// MARK: - Public Properties

	weak var view: CreateTourneyViewProtocol?
	let interactor: CreateTourneyInteractorProtocol
	let router: CreateTourneyRouterProtocol

	// MARK: - Private Properties

	private var isPublicGameSelected: Bool?
	private var priceText: String?
	private var playersCount: Int = CounterType.players.minValue
	private var playersInvited: [InvitePlayerModel] = []

	// MARK: - Initializers

	init(
		interactor: CreateTourneyInteractorProtocol,
		router: CreateTourneyRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		updateSaveButtonState()
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func updateGamePrivacyState(isPublic: Bool) {
		isPublicGameSelected = isPublic
		updateSaveButtonState()
	}

	func addPaymentButtonTapped() {
		// TODO: need to add payment account to profile
		guard let accountNumber = interactor.getAccountNumber() else {
			print("need to add payment account to profile")
			return
		}

		view?.updateAccountInfo(accountNumber: accountNumber)

		updateSaveButtonState()
	}

	func saveTourneyButtonTapped() {
		guard
			let priceText = priceText,
			!priceText.isEmpty,
			let isPublicGameSelected,
			let price = Double(priceText),
			let accountNumber = interactor.getAccountNumber()
		else { return }

		interactor.saveTourney(
			price: price,
			isPublic: isPublicGameSelected,
			accountNumber: accountNumber
		)
	}

	func priceChangedTo(value: String?) {
		priceText = value
		updateSaveButtonState()
	}

	func updatePlayersCount(to count: Int) {
		playersCount = count
	}
}

// MARK: - Private Methods

private extension CreateTourneyPresenter {

	func updateSaveButtonState() {
		guard
			isPublicGameSelected != nil,
			interactor.getAccountNumber() != nil
		else { return }

		let hasText = !(priceText?.isEmpty ?? true)
		view?.updateSaveButtonState(isEnabled: hasText)
	}
}

// MARK: - CreateTourneyInteractorOutputProtocol

extension CreateTourneyPresenter: CreateTourneyInteractorOutputProtocol {

	func tourneySaved(success: Bool) {
		if success {
			print("Tourney Saved")
			// TODO: redirect to ...
			router.navigateBack()
		}
	}

	func accountNumberReceived(_ accountNumber: String) {
		view?.updateAccountInfo(accountNumber: accountNumber)
	}
}
