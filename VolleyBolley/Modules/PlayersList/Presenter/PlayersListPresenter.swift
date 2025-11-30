//
//  PlayersListPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import UIKit

// MARK: - PlayersListPresenterProtocol

protocol PlayersListPresenterProtocol: AnyObject {
	func viewDidLoad()
	func backButtonTapped()
	func getPlayersCount(list: PlayersListType) -> Int
	func getPlayerFrom(list: PlayersListType, at index: Int) -> PlayerListCellViewModel
}

// MARK: - PlayersListPresenter

final class PlayersListPresenter: PlayersListPresenterProtocol {

	// MARK: - Public Properties

	weak var view: PlayersListViewControllerProtocol?
	var interactor: PlayersListInteractorProtocol?
	var router: PlayersListRouterProtocol

	// MARK: - Private Properties

	private var allPlayers: [PlayerInfoModel] = []
	private var favoritePlayers: [PlayerInfoModel] = []

	// MARK: - Initializers

	init(
		interactor: PlayersListInteractorProtocol,
		router: PlayersListRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		allPlayers = interactor?.getPlayers() ?? []
		favoritePlayers = allPlayers.filter{ $0.isFavorite == true }.sorted { $0.firstName < $1.firstName }
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func getPlayersCount(list: PlayersListType) -> Int {
		switch list {
		case .all:
			return allPlayers.count
		case .favorite:
			return favoritePlayers.count
		}
	}

	func getPlayerFrom(list: PlayersListType, at index: Int) -> PlayerListCellViewModel {
		let player: PlayerInfoModel
		let avatar = UIImage.imgPerson // TODO: - загрузить картинку для игрока
		switch list {
		case .all:
			player = allPlayers[index]
		case .favorite:
			player = favoritePlayers[index]
		}

		let model = PlayerListCellViewModel(
			avatar: UIImage.imgPerson,
			firstName: player.firstName,
			lastName: player.lastName,
			isFavorite: player.isFavorite,
			level: PlayerLevel.medium.title
		) { [weak self] in
			guard let self else { return }
			let newPlayer = toggleIsFavoriteFor(player: player)
			self.updateAllPlayersList(with: newPlayer)
			self.updateFavoriteList(with: newPlayer)
		}

		return model
	}
}

// MARK: - Private Methods

private extension PlayersListPresenter {

	func toggleIsFavoriteFor(player: PlayerInfoModel) -> PlayerInfoModel {
		let newPlayer = player.copy(isFavorite: !player.isFavorite)
		interactor?.toggleIsFavoriteFor(player: newPlayer)
		return newPlayer
	}

	func updateAllPlayersList(with player: PlayerInfoModel) {
		allPlayers = allPlayers.map { $0.playerId == player.playerId ? player : $0 }
	}

	func updateFavoriteList(with player: PlayerInfoModel) {
		favoritePlayers = favoritePlayers.map { $0.playerId == player.playerId ? player : $0 }

		if let index = favoritePlayers.firstIndex(of: player) {
			if player.isFavorite == false {
				favoritePlayers.remove(at: index)
			}
		} else if player.isFavorite {
			favoritePlayers.append(player)
		}

		favoritePlayers = favoritePlayers.sorted { $0.firstName < $1.firstName }
	}
}
