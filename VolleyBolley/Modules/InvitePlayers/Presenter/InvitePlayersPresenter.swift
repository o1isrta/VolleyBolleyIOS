//
//  InvitePlayersPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import UIKit

// MARK: - InvitePlayersPresenterProtocol

protocol InvitePlayersPresenterProtocol: AnyObject {
	func viewDidLoad()
	func backButtonTapped()
	func setPlayersList(_ list: PlayersListType)
	func getPlayersCount() -> Int
	func getPlayer(at index: Int) -> InvitePlayersCellViewModel
	func filterPlayers(by filterText: String)
}

// MARK: - InvitePlayersPresenter

final class InvitePlayersPresenter: InvitePlayersPresenterProtocol {

	// MARK: - Public Properties

	weak var view: InvitePlayersViewControllerProtocol?
	var interactor: InvitePlayersInteractorProtocol?
	var router: InvitePlayersRouterProtocol

	// MARK: - Private Properties

	private var allPlayers: [UserInfoModel] = []
	private var players: [UserInfoModel] = []
	private var filteredPlayers: [UserInfoModel] = []

	// MARK: - Initializers

	init(
		interactor: InvitePlayersInteractorProtocol,
		router: InvitePlayersRouterProtocol
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
			players = allPlayers.filter { $0.isFavorite == true }.sorted { $0.firstName < $1.firstName }
		}
		filteredPlayers = players
	}

	func getPlayersCount() -> Int {
		filteredPlayers.count
	}

	func getPlayer(at index: Int) -> InvitePlayersCellViewModel {
		let player = filteredPlayers[index]
		let model = InvitePlayersCellViewModel(
			firstName: player.firstName,
			lastName: player.lastName,
			level: PlayerLevel.medium.title,
			isFavorite: player.isFavorite,
			isSelected: false // TODO: -
		) { [weak self] isFavorite in
			guard let self else { return }
			let newPlayer = self.updateIsFavorite(for: player, to: isFavorite)
			self.updatePlayersList(with: newPlayer)
//		} onCheckmarkToggle: { [weak self] isSelected in
		} onCheckmarkToggle: { isSelected in
//			guard let self else { return }
			// TODO: -
			print("onCheckmarkToggle что-то там делаем: \(isSelected)")
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

private extension InvitePlayersPresenter {

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
