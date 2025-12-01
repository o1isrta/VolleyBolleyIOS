//
//  PlayersListAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import Swinject

final class PlayersListAssembly: Assembly {

	func assemble(container: Container) {
		container.register(PlayersListViewController.self) { resolver in
			let userCardFactory: (PlayerInfoModel) -> UserCardViewController? = { player in
				resolver.resolve(UserCardViewController.self, argument: player)
			}
			let router = PlayersListRouter(userCardFactory: userCardFactory)

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
