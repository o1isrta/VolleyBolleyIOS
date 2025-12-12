//
//  UserCardAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import Swinject

final class UserCardAssembly: Assembly {

	func assemble(container: Container) {
		container.register(UserCardViewController.self) { (_: Resolver, user: UserInfoModel) in
			let router = UserCardRouter()
			let interactor = UserCardInteractor()
			let presenter = UserCardPresenter(
				interactor: interactor,
				router: router,
				user: user
			)
			let viewController = UserCardViewController()
			viewController.presenter = presenter
			router.attachViewController(viewController)
			presenter.view = viewController

			return viewController
		}
	}
}
