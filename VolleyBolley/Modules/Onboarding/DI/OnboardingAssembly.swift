//
//  OnboardingAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class OnboardingAssembly: Assembly {

	func assemble(container: Container) {
		container.register(OnboardingViewController.self) { resolver in
			guard
				let interactor = resolver.resolve(OnboardingInteractorProtocol.self),
				let appRouter = resolver.resolve(AppRouter.self)
			else {
				fatalError("Error: Failed to register OnboardingInteractorProtocol")
			}

			let onboardingVC = OnboardingViewController()

			let router = OnboardingRouter(
				viewController: onboardingVC,
				router: appRouter
			)
			let presenter = OnboardingPresenter(
				view: onboardingVC,
				interactor: interactor,
				router: router
			)
			onboardingVC.presenter = presenter
			return onboardingVC
		}

		container.register(OnboardingInteractorProtocol.self) { resolver in
			guard let userSessionService = resolver.resolve(UserSessionServiceProtocol.self) else {
				fatalError("Error: Failed to resolve UserSessionServiceProtocol")
			}
			return OnboardingInteractor(userSessionService: userSessionService)
		}
	}
}
