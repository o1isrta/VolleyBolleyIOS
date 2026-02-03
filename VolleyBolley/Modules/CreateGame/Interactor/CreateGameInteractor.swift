//
//  CreateGameInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Foundation

protocol CreateGameInteractorProtocol: AnyObject {
	var presenter: CreateGameInteractorOutputProtocol? { get set }

	func saveGame(
		price: Double,
		isPublic: Bool,
		playersCount: Int,
		accountNumber: String,
		playersInvited: [InvitePlayerModel]
	)
	func getAccountNumber() -> String?
}

protocol CreateGameInteractorOutputProtocol: AnyObject {
	func gameSaved(success: Bool)
	func accountNumberReceived(_ accountNumber: String)
}

final class CreateGameInteractor: CreateGameInteractorProtocol {

	// MARK: - Public Properties

	weak var presenter: CreateGameInteractorOutputProtocol?

	// MARK: - Public Methods

	func saveGame(
		price: Double,
		isPublic: Bool,
		playersCount: Int,
		accountNumber: String,
		playersInvited: [InvitePlayerModel]
	) {
		print("Save Game Button clicked")
		print("Price Double: \(String(describing: price))")
		print("Account: \(accountNumber)")
		print("Public game: \(isPublic)")
		print("Players counter: \(playersCount)")
		print("Players invited: \(playersInvited)")
		// TODO: There should be some logic for saving the game here.
		presenter?.gameSaved(success: true)
	}

	func getAccountNumber() -> String? {
		// TODO: replace it to choice of payment method in the future
		return String(localized: "payment.cash")
	}
}
