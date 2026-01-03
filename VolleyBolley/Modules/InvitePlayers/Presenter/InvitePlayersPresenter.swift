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
	func numberOfSections() -> Int
	func getPlayersCount(in section: Int) -> Int
	func getPlayer(at indexPath: IndexPath) -> InvitePlayersCellViewModel
	func filterPlayers(by filterText: String)
	func didTapInviteButton()
	func didTapAddButton()
}

// MARK: - InvitePlayersPresenter

final class InvitePlayersPresenter: InvitePlayersPresenterProtocol {

	// MARK: - Public Properties

	weak var view: InvitePlayersViewControllerProtocol?
	var interactor: InvitePlayersInteractorProtocol?
	var router: InvitePlayersRouterProtocol

	// MARK: - Private Properties

	private var allPlayers: [InvitePlayerModel] = []
	private var pinnedPlayers: [InvitePlayerModel] = []
	private var players: [InvitePlayerModel] = []
	private var filteredPlayers: [InvitePlayerModel] = []

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
			// TODO: - remove in the future
			try await Task.sleep(for: .seconds(2))
			reloadPlayers()
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
			players = allPlayers.filter { $0.isFavorite == true }.sorted { $0.name < $1.name }
		}
		filteredPlayers = players
	}

	func numberOfSections() -> Int { InvitePlayerType.allCases.count }

	func getPlayersCount(in section: Int) -> Int {
		section == InvitePlayerType.invited.rawValue ? pinnedPlayers.count : filteredPlayers.count
	}

	func getPlayer(at indexPath: IndexPath) -> InvitePlayersCellViewModel {
		let player = indexPath.section == InvitePlayerType.invited.rawValue
			? pinnedPlayers[indexPath.row]
			: filteredPlayers[indexPath.row]

		let model = InvitePlayersCellViewModel(
			name: player.name,
			level: PlayerLevel.medium.title,
			isFavorite: player.isFavorite,
			isPinned: player.isPinned,
			isSelected: player.isSelected
		) { [weak self] isFavorite in
			guard let self else { return }
			let newPlayer = self.updateIsFavorite(for: player, to: isFavorite)
			self.updatePlayersList(with: newPlayer)
		} onCheckmarkToggle: { [weak self] isSelected in
			guard let self else { return }
			guard indexPath.section == InvitePlayerType.regular.rawValue else { return }
			let newPlayer = player.copy(isSelected: isSelected)
			self.updatePlayersList(with: newPlayer)
		}

		return model
	}

	func filterPlayers(by filterText: String) {
		let filterText = filterText.lowercased()
		filteredPlayers = players.filter { player in
			filterText.isEmpty
			|| player.name.localizedCaseInsensitiveContains(filterText)
		}
	}

	func didTapInviteButton() {
		pinnedPlayers = players.filter { $0.isSelected }
		players = players.filter { !$0.isSelected }
		filteredPlayers = filteredPlayers.filter { !$0.isSelected }

		view?.isLoadingIndicatorVisible(true)
		Task {
			interactor?.pinSelectedPlayers(pinnedPlayers)

			// TODO: - remove in the future
			try await Task.sleep(for: .seconds(2))

			await MainActor.run {
				view?.isLoadingIndicatorVisible(false)
				self.reloadPlayers()
				self.view?.reloadData()
				self.view?.showAlert(with: String(localized: "invitePlayers.invitationSuccessfullySent"))
			}
		}
	}

	func didTapAddButton() {
		// TODO: - прокидываем выбранных игроков на экран создания игры
		let selectedPlayers = players.filter { $0.isSelected }
		print("selected players: \(selectedPlayers)")
	}
}

// MARK: - Private Methods

private extension InvitePlayersPresenter {

	func reloadPlayers() {
		allPlayers = interactor?.getRegularPlayers() ?? []
		pinnedPlayers = interactor?.getPinnedPlayers() ?? []
	}

	func updateIsFavorite(for user: InvitePlayerModel, to isFavorite: Bool) -> InvitePlayerModel {
		let newUser = user.copy(isFavorite: isFavorite)
		interactor?.toggleIsFavoriteFor(user: newUser)
		return newUser
	}

	func updatePlayersList(with user: InvitePlayerModel) {
		allPlayers = allPlayers.map { $0.id == user.id ? user : $0 }
		players = players.map { $0.id == user.id ? user : $0 }
		filteredPlayers = filteredPlayers.map { $0.id == user.id ? user : $0 }
		pinnedPlayers = pinnedPlayers.map { $0.id == user.id ? user : $0 }
	}
}
