//
//  InvitePlayersInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Foundation

// MARK: - InvitePlayersInteractor

protocol InvitePlayersInteractorProtocol: AnyObject {
	func fetchPlayers()
	func pinSelectedPlayers(_ pinnedPlayers: [InvitePlayerModel])
	func getPinnedPlayers() -> [InvitePlayerModel]
	func getRegularPlayers() -> [InvitePlayerModel]
	func toggleIsFavoriteFor(user: InvitePlayerModel)
}

// MARK: - InvitePlayersInteractor

final class InvitePlayersInteractor: InvitePlayersInteractorProtocol {

	// MARK: - Private Properties

//	private let networkService: NetworkServiceProtocol
	private var players: [InvitePlayerModel] = []

	// MARK: - Initializers

	init(
//		networkService: NetworkServiceProtocol,
	) {
//		self.networkService = networkService
		fetchPlayers()
	}

	// MARK: - Public Methods

	func fetchPlayers() {
		// TODO: - get Data from network
		players = [
			InvitePlayerModel(
				id: 0,
				name: "Aleksandr Abramov",
				isFavorite: false,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.pro.title
			),
			InvitePlayerModel(
				id: 1,
				name: "Polina Vasilieva",
				isFavorite: false,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.pro.title
			),
			InvitePlayerModel(
				id: 2,
				name: "Kristina Popova",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.medium.title
			),
			InvitePlayerModel(
				id: 3,
				name: "Anton Ivanov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.light.title
			),
			InvitePlayerModel(
				id: 4,
				name: "Aleksandr Vavilov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.pro.title
			),
			InvitePlayerModel(
				id: 12,
				name: "Kristina Popova",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.medium.title
			),
			InvitePlayerModel(
				id: 13,
				name: "Anton Ivanov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.light.title
			),
			InvitePlayerModel(
				id: 14,
				name: "Aleksandr Vavilov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.pro.title
			),
			InvitePlayerModel(
				id: 22,
				name: "Kristina Popova",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.medium.title
			),
			InvitePlayerModel(
				id: 23,
				name: "Anton Ivanov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.light.title
			),
			InvitePlayerModel(
				id: 24,
				name: "Aleksandr Vavilov",
				isFavorite: true,
				isPinned: false,
				isSelected: false,
				level: PlayerLevel.pro.title
			)
		]
	}

	func pinSelectedPlayers(_ pinnedPlayers: [InvitePlayerModel]) {
		let pinnedIds = Set(pinnedPlayers.map { $0.id })

		players = players.map { player in
			guard pinnedIds.contains(player.id) else { return player }
			return InvitePlayerModel(
				id: player.id,
				name: player.name,
				isFavorite: player.isFavorite,
				isPinned: true,
				isSelected: true,
				level: player.level
			)
		}
	}

	func getPinnedPlayers() -> [InvitePlayerModel] {
		players.filter { $0.isPinned }
	}

	func getRegularPlayers() -> [InvitePlayerModel] {
		players.filter { !$0.isPinned }
	}

	func toggleIsFavoriteFor(user: InvitePlayerModel) {
		// TODO: - send data to server
		print("toggleIsFavoriteFor", user.isFavorite)
		if user.isFavorite {
			// add - POST /games/{game_id}/invite-players | /tournaments/{tournament_id}/invite-players
		} else {
			// remove - DELETE ???
		}
	}
}
