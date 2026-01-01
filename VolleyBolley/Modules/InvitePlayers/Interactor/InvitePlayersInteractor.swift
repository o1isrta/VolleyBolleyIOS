//
//  InvitePlayersInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Foundation

// MARK: - InvitePlayersInteractor

protocol InvitePlayersInteractorProtocol: AnyObject {
	func getPlayers() -> [UserInfoModel]
	func toggleIsFavoriteFor(user: UserInfoModel)
}

// MARK: - InvitePlayersInteractor

final class InvitePlayersInteractor: InvitePlayersInteractorProtocol {

	// MARK: - Private Properties

//	private let networkService: NetworkServiceProtocol

	// MARK: - Initializers

	init(
//		networkService: NetworkServiceProtocol,
	) {
//		self.networkService = networkService
	}

	// MARK: - Public Methods

	func getPlayers() -> [UserInfoModel] {
		// TODO: - get Data from network
		[
			UserInfoModel(
				playerId: 0,
				firstName: "Aleksandr",
				lastName: "Abramov",
				avatar: "https://www.leningrad.ru",
				isFavorite: false,
				level: PlayerLevel.pro.title
			),
			UserInfoModel(
				playerId: 1,
				firstName: "Polina",
				lastName: "Vasilieva",
				avatar: nil,
				isFavorite: false,
				level: PlayerLevel.pro.title
			),
			UserInfoModel(
				playerId: 2,
				firstName: "Kristina",
				lastName: "Popova",
				avatar: "https://www.leningrad.ru",
				isFavorite: true,
				level: PlayerLevel.medium.title
			),
			UserInfoModel(
				playerId: 3,
				firstName: "Anton",
				lastName: "Ivanov",
				avatar: nil,
				isFavorite: true,
				level: PlayerLevel.light.title
			),
			UserInfoModel(
				playerId: 4,
				firstName: "Aleksandr",
				lastName: "Vavilov",
				avatar: "https://www.leningrad.ru",
				isFavorite: true,
				level: PlayerLevel.pro.title
			)
		]
	}

	func toggleIsFavoriteFor(user: UserInfoModel) {
		// TODO: - send data to server
		print("toggleIsFavoriteFor", user.isFavorite)
		if user.isFavorite {
			// add - POST /games/{game_id}/invite-players | /tournaments/{tournament_id}/invite-players
		} else {
			// remove - DELETE ???
		}
	}
}
