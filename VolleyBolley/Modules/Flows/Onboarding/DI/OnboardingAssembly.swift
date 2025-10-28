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
				let userSessionService = resolver.resolve(UserSessionServiceProtocol.self),
				let appRouter = resolver.resolve(AppRouter.self)
			else {
				fatalError("Error: Failed to resolve dependencies for OnboardingViewController")
			}
			let onboardingVC = OnboardingViewController()
			let interactor = OnboardingInteractor(userSessionService: userSessionService)
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
	}
}
