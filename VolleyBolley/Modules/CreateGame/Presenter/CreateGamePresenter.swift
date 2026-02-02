//
//  CreateGamePresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol CreateGamePresenterProtocol: AnyObject {
	var view: CreateGameViewProtocol? { get set }
	var interactor: CreateGameInteractorProtocol { get }
	var router: CreateGameRouterProtocol { get }

	func viewDidLoad()
	func backButtonTapped()
	func updateGamePrivacyState(isPublic: Bool)
	func managePlayersButtonTapped()
	func addPaymentButtonTapped()
	func saveGameButtonTapped()
	func priceChangedTo(value: String?)
	func updatePlayersCount(to count: Int)
	func didSelectPlayers(_ players: [InvitePlayerModel])
	func getPlayersCount() -> Int
	func getPlayerBy(index: Int) -> InvitePlayerModel
	func removePlayerBy(index: Int)
}

final class CreateGamePresenter: CreateGamePresenterProtocol {

	// MARK: - Public Properties

	weak var view: CreateGameViewProtocol?
	let interactor: CreateGameInteractorProtocol
	let router: CreateGameRouterProtocol

	// MARK: - Private Properties

	private var isPublicGameSelected: Bool?
	private var priceText: String?
	private var playersCount: Int = CounterType.players.minValue
	private var playersInvited: [InvitePlayerModel] = []

	// MARK: - Initializers

	init(
		interactor: CreateGameInteractorProtocol,
		router: CreateGameRouterProtocol
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
		view?.isPlayersListHidden(isPublic)
		updateSaveButtonState()
	}

	func managePlayersButtonTapped() {
		router.openInvitePlayersScreen()
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

	func saveGameButtonTapped() {
		guard
			let priceText = priceText,
			!priceText.isEmpty,
			let isPublicGameSelected,
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

	func priceChangedTo(value: String?) {
		priceText = value
		updateSaveButtonState()
	}

	func updatePlayersCount(to count: Int) {
		playersCount = count
	}

	func didSelectPlayers(_ players: [InvitePlayerModel]) {
		let playersInvitedSet = Set(playersInvited)
		playersInvited += players.filter { !playersInvitedSet.contains($0) }
		view?.reloadPlayersTableData()
	}

	func getPlayersCount() -> Int {
		playersInvited.count
	}

	func getPlayerBy(index: Int) -> InvitePlayerModel {
		playersInvited[index]
	}

	func removePlayerBy(index: Int) {
		playersInvited.remove(at: index)
		view?.reloadPlayersTableData()
	}
}

// MARK: - Private Methods

private extension CreateGamePresenter {

	func updateSaveButtonState() {
		guard
			isPublicGameSelected != nil,
			interactor.getAccountNumber() != nil
		else { return }

		let hasText = !(priceText?.isEmpty ?? true)
		view?.updateSaveButtonState(isEnabled: hasText)
	}
}

// MARK: - CreateGameInteractorOutputProtocol

extension CreateGamePresenter: CreateGameInteractorOutputProtocol {

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

