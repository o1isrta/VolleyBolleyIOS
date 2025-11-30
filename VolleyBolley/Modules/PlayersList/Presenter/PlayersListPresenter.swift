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
	func setPlayersList(_ list: PlayersListType)
	func getPlayersCount() -> Int
	func getPlayer(at index: Int) -> PlayerListCellViewModel
	func filterPlayers(by filterText: String)
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

	private var players: [PlayerInfoModel] = [] {
		didSet {
			filterPlayers(by: "")
		}
	}
	private var filteredPlayers: [PlayerInfoModel] = []

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
		setPlayersList(.all)
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func setPlayersList(_ list: PlayersListType) {
		switch list {
		case .all:
			players = allPlayers
		case .favorite:
			players = favoritePlayers
		}
	}

	func getPlayersCount() -> Int {
		filteredPlayers.count
	}

	func getPlayer(at index: Int) -> PlayerListCellViewModel {
		let player = filteredPlayers[index]
		let avatar = UIImage.imgPerson // TODO: - загрузить картинку для игрока

		let model = PlayerListCellViewModel(
			avatar: UIImage.imgPerson,
			firstName: player.firstName,
			lastName: player.lastName,
			isFavorite: player.isFavorite,
			level: PlayerLevel.medium.title
		) { [weak self] isFavorite in
			guard let self else { return }
			let newPlayer = updateIsFavorite(for: player, to: isFavorite)
			self.updateAllPlayersList(with: newPlayer)
			self.updateFavoriteList(with: newPlayer)
		}

		return model
	}

	func filterPlayers(by filterText: String) {
		let filterText = filterText.lowercased()
		filteredPlayers = players.filter { player in
			return filterText.isEmpty
				|| player.firstName.localizedCaseInsensitiveContains(filterText)
				|| player.lastName.localizedCaseInsensitiveContains(filterText)
		}
	}
}

// MARK: - Private Methods

private extension PlayersListPresenter {

	func updateIsFavorite(for player: PlayerInfoModel, to isFavorite: Bool) -> PlayerInfoModel {
		let newPlayer = player.copy(isFavorite: isFavorite)
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
