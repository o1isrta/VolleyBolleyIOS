//
//  RegistrationAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import Swinject
import UIKit

final class RegistrationAssembly: Assembly {

	func assemble(container: Container) {
		container.register(RegistrationViewController.self) { resolver in
			let registrationVC = RegistrationViewController()

			let interactor = resolver.resolve(RegistrationInteractorProtocol.self)!
			let appRouter = resolver.resolve(AppRouter.self)
			let router = RegistrationRouter(
				viewController: registrationVC,
				router: appRouter
			)
			let presenter = RegistrationPresenter(
				view: registrationVC as RegistrationViewControllerProtocol,
				interactor: interactor,
				router: router
			)
			registrationVC.presenter = presenter
			return registrationVC
		}

		container.register(RegistrationInteractorProtocol.self) { _ in
			RegistrationInteractor()
		}
	}
}
