//
//  InvitePlayersAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Swinject

final class InvitePlayersAssembly: Assembly {

	func assemble(container: Container) {
		container.register(InvitePlayersViewControllerProtocol.self) { _ in
			let router = InvitePlayersRouter()
			let interactor = InvitePlayersInteractor()
			let presenter = InvitePlayersPresenter(
				interactor: interactor,
				router: router
			)

			let viewController = InvitePlayersViewController(presenter: presenter)
			router.attachViewController(viewController)
			presenter.view = viewController

			return viewController
		}
	}
}
