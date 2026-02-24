//
//  AuthAssembly.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import Swinject
import UIKit

final class AuthAssembly: Assembly {

	func assemble(container: Container) {
		container.register(AuthRouterProtocol.self) { resolver in
			AuthRouter(
				window: resolver.safeResolve(UIWindow.self),
				viewControllerFactory: {
					resolver.safeResolve(AuthViewController.self)
				},
				registrationFactory: {
					resolver.safeResolve(RegistrationViewController.self)
				}
			)
		}
		.inObjectScope(.container)

		container.register(AuthViewController.self) { resolver in
			let router = resolver.safeResolve(AuthRouterProtocol.self)

			let interactor = AuthInteractor(
				googleAuthService: resolver.safeResolve(GoogleOAuthServiceProtocol.self),
				firebaseAuthService: resolver.safeResolve(FirebaseAuthServiceProtocol.self),
				authRepository: resolver.safeResolve(AuthRepositoryProtocol.self),
				router: router
			)

			let presenter = AuthPresenter(
				interactor: interactor,
				router: router
			)

			let authVC = AuthViewController(presenter: presenter)
			presenter.view = authVC

			return authVC
		}
	}
}
