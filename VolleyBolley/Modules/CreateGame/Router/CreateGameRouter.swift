//
//  CreateGameRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol CreateGameRouterProtocol: AnyObject {
	func navigateBack()
	func openInvitePlayersScreen()
}

final class CreateGameRouter: CreateGameRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?
	private let invitePlayersFactory: (InvitePlayersListType) -> InvitePlayersViewController?

	// MARK: - Initializers

	init(
		viewController: UIViewController,
		invitePlayersFactory: @escaping (InvitePlayersListType) -> InvitePlayersViewController?
	) {
		self.viewController = viewController
		self.invitePlayersFactory = invitePlayersFactory
	}

	// MARK: - Public Methods

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func openInvitePlayersScreen() {
		guard let invitePlayersVC = invitePlayersFactory(.privateGame) else {
			fatalError("InvitePlayersViewController could not be created")
		}

		invitePlayersVC.onPlayersSelected = { [weak self] players in
			(self?.viewController as? CreateGameViewController)?.presenter?.didSelectPlayers(players)
		}

		viewController?.navigationController?.pushViewController(invitePlayersVC, animated: true)
	}
}
