//
//  CreateGameRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol CreateGameRouterProtocol: AnyObject {
	func navigateBack()
	func openInvitePlayersScreen(
		maxPlayers: Int,
		playersInvited: [InvitePlayerModel],
		onSelected: @escaping ([InvitePlayerModel]) -> Void
	)
}

final class CreateGameRouter: CreateGameRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	private let invitePlayersFactory: (
		InvitePlayersListType,
		Int,
		[InvitePlayerModel],
		@escaping ([InvitePlayerModel]) -> Void
	) -> InvitePlayersViewController?

	// MARK: - Initializers

	init(
		viewController: UIViewController,
		invitePlayersFactory: @escaping (
			InvitePlayersListType,
			Int,
			[InvitePlayerModel],
			@escaping ([InvitePlayerModel]) -> Void
		) -> InvitePlayersViewController?
	) {
		self.viewController = viewController
		self.invitePlayersFactory = invitePlayersFactory
	}

	// MARK: - Public Methods

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func openInvitePlayersScreen(
		maxPlayers: Int,
		playersInvited: [InvitePlayerModel],
		onSelected: @escaping ([InvitePlayerModel]) -> Void
	) {
		guard let invitePlayersVC = invitePlayersFactory(.privateGame, maxPlayers, playersInvited, onSelected) else {
			fatalError("InvitePlayersViewController could not be created")
		}
		viewController?.navigationController?.pushViewController(invitePlayersVC, animated: true)
	}
}
