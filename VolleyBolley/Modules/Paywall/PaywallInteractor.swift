//
//  PaywallInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Foundation

protocol PaywallInteractorProtocol: AnyObject {
	var presenter: PaywallInteractorOutputProtocol? { get set }

	func saveGame(price: Double, isPublic: Bool, playersCount: Int, accountNumber: String)
	func getAccountNumber() -> String?
}

protocol PaywallInteractorOutputProtocol: AnyObject {
	func gameSaved(success: Bool)
	func accountNumberReceived(_ accountNumber: String)
}

final class PaywallInteractor: PaywallInteractorProtocol {

	// MARK: - Public Properties

	weak var presenter: PaywallInteractorOutputProtocol?

	// MARK: - Private Properties

	private let playersRepository: PlayersRepositoryProtocol

	// MARK: - Initializers

	init(playersRepository: PlayersRepositoryProtocol) {
		self.playersRepository = playersRepository
	}

	// MARK: - Public Methods

	func saveGame(price: Double, isPublic: Bool, playersCount: Int, accountNumber: String) {
		print("Save Game Button clicked")
		print("Price Double: \(String(describing: price))")
		print("Account: \(accountNumber)")
		print("Public game: \(isPublic)")
		print("Players counter: \(playersCount)")
		// TODO: There should be some logic for saving the game here.
		presenter?.gameSaved(success: true)
	}

	func getAccountNumber() -> String? {
		// TODO: remove in in the future
		return "988 016 7890"
	}
}
