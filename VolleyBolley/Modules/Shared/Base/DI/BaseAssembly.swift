//
//  BaseAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.09.2025.
//

import Swinject
import UIKit

final class BaseAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> CustomNavBarView {
		let view = CustomNavBarView()
		let presenter = BasePresenter()
		let interactor = BaseInteractor()
		let router = BaseRouter()
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
		container.register(BasePresenterProtocol.self) { _ in
			BasePresenter()
		}

		container.register(BaseInteractorInputProtocol.self) { resolver in
			let interactor = BaseInteractor()
			interactor.presenter = resolver.resolve(BasePresenterProtocol.self) as? BaseInteractorOutputProtocol
			return interactor
		}

		container.register(BaseRouterProtocol.self) { _ in
			BaseRouter()
		}

		container.register(CustomNavBarView.self) { resolver in
			let view = CustomNavBarView()
			let presenter = resolver.resolve(BasePresenterProtocol.self)
			let interactor = resolver.resolve(BaseInteractorInputProtocol.self)
			let router = resolver.resolve(BaseRouterProtocol.self)

			view.presenter = presenter
			presenter?.view = view
			presenter?.interactor = interactor
			presenter?.router = router

			return view
		}
	}
}
