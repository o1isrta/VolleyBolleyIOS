//
//  RegistrationAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import Swinject
import UIKit

final class RegistrationAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> RegistrationViewController {
		let registrationVC = RegistrationViewController()
		let router = RegistrationRouter(viewController: registrationVC)
		let presenter = RegistrationPresenter(
			router: router
		)
		registrationVC.presenter = presenter
		presenter.view = registrationVC

		return registrationVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(RegistrationViewController.self) { _ in
			RegistrationAssembly.createModule(with: nil)
		}
	}

//	func assemble(container: Container) {
//		container.register(RegistrationViewController.self) { resolver in
////			let registrationVC = resolver.resolve(RegistrationViewControllerProtocol.self)!
//			let registrationVC = RegistrationViewController()
//
//			let interactor = resolver.resolve(RegistrationInteractorProtocol.self)!
//			let appRouter = resolver.resolve(AppRouter.self)
//			let router = RegistrationRouter(
//				viewController: registrationVC,
//				coordinator: appRouter
//			)
//			let presenter = RegistrationPresenter(
//				view: registrationVC as! RegistrationViewControllerProtocol,
//				interactor: interactor//,
////				router: router
//			)
//
////			registrationVC.presenter = presenter
//			return registrationVC
//		}
//
//		container.register(RegistrationInteractorProtocol.self) { _ in
//			RegistrationInteractor()
//		}
//	}
}

