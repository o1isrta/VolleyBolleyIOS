//
//  InvitePlayersAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Swinject

final class InvitePlayersAssembly: Assembly {

	func assemble(container: Container) {
		container.register(
			InvitePlayersViewController.self
		) { ( _, playersListType: InvitePlayersListType, maxPlayers: Int, invitedPlayers: [InvitePlayerModel]) in
			let router = InvitePlayersRouter()
			let interactor = InvitePlayersInteractor()
			let presenter = InvitePlayersPresenter(
				interactor: interactor,
				router: router,
				invitedPlayers: invitedPlayers,
				maxPlayers: maxPlayers
			)

			let viewController = InvitePlayersViewController(presenter: presenter, playersListType: playersListType)
			router.attachViewController(viewController)
			presenter.view = viewController

			return viewController
		}
	}
}
