//
//  CreateTourneyInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.02.2026.
//

import Foundation

protocol CreateTourneyInteractorProtocol: AnyObject {
	var presenter: CreateTourneyInteractorOutputProtocol? { get set }

	func saveTourney(price: Double, playersOrTeamsCount: Int, accountNumber: String)
	func getAccountNumber() -> String?
}

protocol CreateTourneyInteractorOutputProtocol: AnyObject {
	func tourneySaved(success: Bool)
	func accountNumberReceived(_ accountNumber: String)
}

final class CreateTourneyInteractor: CreateTourneyInteractorProtocol {

	// MARK: - Public Properties

	weak var presenter: CreateTourneyInteractorOutputProtocol?

	// MARK: - Public Methods

	func saveTourney(
		price: Double,
		playersOrTeamsCount: Int,
		accountNumber: String
	) {
		print("Save Tourney Button clicked")
		print("Price Double: \(String(describing: price))")
		print("Account: \(accountNumber)")
		print("Players/Teams count: \(playersOrTeamsCount)")
		// TODO: There should be some logic for saving the game here.
		presenter?.tourneySaved(success: true)
	}

	func getAccountNumber() -> String? {
		// TODO: replace it to choice of payment method in the future
		return String(localized: "payment.cash")
	}
}
