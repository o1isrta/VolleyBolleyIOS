//
//  NavBarAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.09.2025.
//

import Swinject
import UIKit

final class NavBarAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> CustomNavBarView {
		let view = CustomNavBarView()
		let presenter = NavBarPresenter()
		let interactor = NavBarInteractor()
		let router = NavBarRouter()
		// Set up dependencies
		view.presenter = presenter
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.viewController = parentViewController
		// Set the parent view controller for navigation
		view.setViewController(parentViewController)

		return view
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		// Register NavBar components
		container.register(NavBarPresenterProtocol.self) { _ in
			NavBarPresenter()
		}

		container.register(NavBarInteractorInputProtocol.self) { resolver in
			let interactor = NavBarInteractor()
			interactor.presenter = resolver.resolve(NavBarPresenterProtocol.self) as? NavBarInteractorOutputProtocol
			return interactor
		}

		container.register(NavBarRouterProtocol.self) { _ in
			NavBarRouter()
		}

		container.register(CustomNavBarView.self) { resolver in
			let view = CustomNavBarView()
			let presenter = resolver.resolve(NavBarPresenterProtocol.self)
			let interactor = resolver.resolve(NavBarInteractorInputProtocol.self)
			let router = resolver.resolve(NavBarRouterProtocol.self)

			view.presenter = presenter
			presenter?.view = view
			presenter?.interactor = interactor
			presenter?.router = router

			return view
		}
	}
}
