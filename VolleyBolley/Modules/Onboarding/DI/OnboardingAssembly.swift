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
			let userSessionService = resolver.resolve(UserSessionServiceProtocol.self)!
			let interactor = OnboardingInteractor(userSessionService: userSessionService)

			let appRouter = resolver.resolve(AppRouter.self)!
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
	}
}
