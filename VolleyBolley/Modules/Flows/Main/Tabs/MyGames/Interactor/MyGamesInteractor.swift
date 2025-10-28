//
//  MyGamesInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import UIKit

protocol MyGamesInteractorProtocol: AnyObject {
	func getInvitesCount() async -> Int
	func getNextGameDate() async -> Date
}

final class MyGamesInteractor: MyGamesInteractorProtocol {

    // MARK: - Private Properties

    // MARK: - Initializers

    init() {
		// TODO: - get games data from repo
    }

    // MARK: - Public Methods

	func getInvitesCount() async -> Int {
		try? await Task.sleep(for: .seconds(5))
		// TODO:
		print("get InvitesCount")
		return 2
	}

	func getNextGameDate() async -> Date {
		try? await Task.sleep(for: .seconds(3))
		// TODO:
		print("get NextGameDate")
		return Date()
	}
}
