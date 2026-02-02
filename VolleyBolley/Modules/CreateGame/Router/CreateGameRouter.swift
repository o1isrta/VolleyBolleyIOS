//
//  CreateGameRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol CreateGameRouterProtocol: AnyObject {
	func navigateBack()
	func openInvitePlayersScreen(playersInvited: [InvitePlayerModel])
}

final class CreateGameRouter: CreateGameRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?
	private let invitePlayersFactory: (InvitePlayersListType, [InvitePlayerModel]) -> InvitePlayersViewController?

	// MARK: - Initializers

	init(
		viewController: UIViewController,
		invitePlayersFactory: @escaping (InvitePlayersListType, [InvitePlayerModel]) -> InvitePlayersViewController?
	) {
		self.viewController = viewController
		self.invitePlayersFactory = invitePlayersFactory
	}

	// MARK: - Public Methods

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func openInvitePlayersScreen(playersInvited: [InvitePlayerModel]) {
		guard let invitePlayersVC = invitePlayersFactory(.privateGame, playersInvited) else {
			fatalError("InvitePlayersViewController could not be created")
		}

		invitePlayersVC.onPlayersSelected = { [weak self] players in
			(self?.viewController as? CreateGameViewController)?.presenter?.didSelectPlayers(players)
		}

		viewController?.navigationController?.pushViewController(invitePlayersVC, animated: true)
	}
}
