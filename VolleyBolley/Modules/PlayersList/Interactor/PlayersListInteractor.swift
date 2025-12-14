//
//  PlayersListInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import UIKit

// MARK: - PlayersListInteractorProtocol

protocol PlayersListInteractorProtocol: AnyObject {
	func getPlayers() -> [UserInfoModel]
	func toggleIsFavoriteFor(user: UserInfoModel)
	func loadAvatar(for url: URL) async throws -> UIImage?
}

// MARK: - PlayersListInteractor

final class PlayersListInteractor: PlayersListInteractorProtocol {

	// MARK: - Private Properties

//	private let networkService: NetworkServiceProtocol
	private let imageLoader: ImageLoadingServiceProtocol

	// MARK: - Initializers

	init(
//		networkService: NetworkServiceProtocol,
		imageLoader: ImageLoadingServiceProtocol
	) {
//		self.networkService = networkService
		self.imageLoader = imageLoader
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
			// add - POST /players/{player_id}/favorite
		} else {
			// remove - DELETE /player/{player_id}/favorite
		}
	}

	func loadAvatar(for url: URL) async throws -> UIImage? {
		// TODO: - remove gag
		try await Task.sleep(for: .seconds(2))
		return UIImage.imgPerson
//		try await imageLoader.loadImage(from: url)
	}
}
