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
			let userCardFactory: (UserInfoModel) -> UserCardViewController? = { user in
				resolver.resolve(UserCardViewController.self, argument: user)
			}
			let router = PlayersListRouter(userCardFactory: userCardFactory)

			guard let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self) else {
				fatalError("Error: Failed to register ImageLoadingServiceProtocol")
			}
			let interactor = PlayersListInteractor(imageLoader: imageLoader)

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
