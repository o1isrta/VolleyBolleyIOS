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
	func openPlayerCard(index: Int)
	func didRequestAvatar(avatarURLString: String?)
}

// MARK: - PlayersListPresenter

final class PlayersListPresenter: PlayersListPresenterProtocol {

	// MARK: - Public Properties

	weak var view: PlayersListViewControllerProtocol?
	var interactor: PlayersListInteractorProtocol?
	var router: PlayersListRouterProtocol

	// MARK: - Private Properties

	private var allPlayers: [UserInfoModel] = []
	private var players: [UserInfoModel] = []
	private var filteredPlayers: [UserInfoModel] = []

	private var avatarTasks: [String: Task<Void, Never>] = [:]

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
		view?.isLoadingIndicatorVisible(true)
		Task {
			try await Task.sleep(for: .seconds(2))
			allPlayers = interactor?.getPlayers() ?? []
			setPlayersList(.all)

			await MainActor.run {
				view?.isLoadingIndicatorVisible(false)
				self.view?.reloadData()
			}
		}
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func setPlayersList(_ list: PlayersListType) {
		switch list {
		case .all:
			players = allPlayers
		case .favorite:
			players = allPlayers.filter{ $0.isFavorite == true }.sorted { $0.firstName < $1.firstName }
		}
		filteredPlayers = players
	}

	func getPlayersCount() -> Int {
		filteredPlayers.count
	}

	func getPlayer(at index: Int) -> PlayerListCellViewModel {
		let player = filteredPlayers[index]
		let model = PlayerListCellViewModel(
			avatar: player.avatar,
			firstName: player.firstName,
			lastName: player.lastName,
			isFavorite: player.isFavorite,
			level: PlayerLevel.medium.title
		) { [weak self] isFavorite in
			guard let self else { return }
			let newPlayer = self.updateIsFavorite(for: player, to: isFavorite)
			self.updatePlayersList(with: newPlayer)
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

	func didRequestAvatar(avatarURLString: String?) {
		guard
			let avatarURLString,
			let url = URL(string: avatarURLString)
		else {
			return
		}
		avatarTasks[avatarURLString]?.cancel()

		let task = Task { [weak self] in
			guard let self else { return }
			let image = try? await interactor?.loadAvatar(for: url)
			guard !Task.isCancelled else { return }
			await MainActor.run {
				self.view?.setAvatar(image, for: avatarURLString)
			}
		}

		avatarTasks[avatarURLString] = task
	}

	func openPlayerCard(index: Int) {
		let player = filteredPlayers[index]
		router.openUserCard(for: player)
	}
}

// MARK: - Private Methods

private extension PlayersListPresenter {

	func updateIsFavorite(for user: UserInfoModel, to isFavorite: Bool) -> UserInfoModel {
		let newUser = user.copy(isFavorite: isFavorite)
		interactor?.toggleIsFavoriteFor(user: newUser)
		return newUser
	}

	func updatePlayersList(with user: UserInfoModel) {
		allPlayers = allPlayers.map { $0.playerId == user.playerId ? user : $0 }
		players = players.map { $0.playerId == user.playerId ? user : $0 }
		filteredPlayers = filteredPlayers.map { $0.playerId == user.playerId ? user : $0 }
	}
}
