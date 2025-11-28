//
//  PlayersListAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import Swinject

final class PlayersListAssembly: Assembly {

	func assemble(container: Container) {
		container.register(PlayersListViewController.self) { _ in
			let router = PlayersListRouter()
			let interactor = PlayersListInteractor()
			let presenter = PlayersListPresenter(
				interactor: interactor,
				router: router
			)
			let viewController = PlayersListViewController(presenter: presenter)
			router.attachViewController(viewController)
			presenter.view = viewController

			return viewController
		}
	}
}
