//
//  CreateGameAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import Swinject
import UIKit

final class CreateGameAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> CreateGameViewController {
		let paywallVC = CreateGameViewController()
		let interactor = CreateGameInteractor()
		let router = CreateGameRouter(viewController: paywallVC)
		let presenter = CreateGamePresenter(interactor: interactor, router: router)

		paywallVC.presenter = presenter
		interactor.presenter = presenter
		presenter.view = paywallVC

		return paywallVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(CreateGameViewController.self) { _ in
			CreateGameAssembly.createModule(with: nil)
		}
	}
}
