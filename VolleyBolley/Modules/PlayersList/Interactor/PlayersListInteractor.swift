//
//  PlayersListInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import UIKit

// MARK: - PlayersListInteractorProtocol

protocol PlayersListInteractorProtocol: AnyObject {
	func getPlayers() -> [PlayerInfoModel]
	func toggleIsFavoriteFor(player: PlayerInfoModel)
}

// MARK: - PlayersListInteractor

final class PlayersListInteractor: PlayersListInteractorProtocol {

	// MARK: - Public Properties

//	private let networkService: NetworkServiceProtocol

	// MARK: - Initializers

//	init(networkService: NetworkServiceProtocol) {
//		self.networkService = networkService
//	}

	// MARK: - Public Methods

	func getPlayers() -> [PlayerInfoModel] {
		// TODO: - get Data from network
		[
			PlayerInfoModel(
				playerId: 0,
				firstName: "Aleksandr",
				lastName: "Abramov",
				avatar: nil,
				isFavorite: false,
				level: PlayerLevel.pro.title
			),
			PlayerInfoModel(
				playerId: 1,
				firstName: "Polina",
				lastName: "Vasilieva",
				avatar: nil,
				isFavorite: false,
				level: PlayerLevel.pro.title
			),
			PlayerInfoModel(
				playerId: 2,
				firstName: "Kristina",
				lastName: "Popova",
				avatar: nil,
				isFavorite: true,
				level: PlayerLevel.medium.title
			),
			PlayerInfoModel(
				playerId: 3,
				firstName: "Anton",
				lastName: "Ivanov",
				avatar: nil,
				isFavorite: true,
				level: PlayerLevel.light.title
			),
			PlayerInfoModel(
				playerId: 4,
				firstName: "Aleksandr",
				lastName: "Vavilov",
				avatar: nil,
				isFavorite: true,
				level: PlayerLevel.pro.title
			)
		]
	}

	func toggleIsFavoriteFor(player: PlayerInfoModel) {
		// TODO: - send data to server
		print("toggleIsFavoriteFor", player.isFavorite)
		if player.isFavorite {
			// add - POST /players/{player_id}/favorite
		} else {
			// remove - DELETE /player/{player_id}/favorite
		}
	}
}
