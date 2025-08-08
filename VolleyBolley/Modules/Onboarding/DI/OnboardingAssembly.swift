//
//  OnboardingAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

class OnboardingAssembly: Assembly {
    func assemble(container: Container) {

        container.register(OnboardingViewController.self) { resolver in
            guard let userSessionService = resolver.resolve(UserSessionServiceProtocol.self) else {
                fatalError("Error: Failed to resolve UserSessionServiceProtocol")
            }

            guard let router = resolver.resolve(OnboardingRouterProtocol.self) else {
                fatalError("Error: Failed to resolve OnboardingRouterProtocol")
            }

            let interactor = OnboardingInteractor(userSessionService: userSessionService)
            let presenter = OnboardingPresenter(interactor: interactor, router: router)
            let viewController = OnboardingViewController(presenter: presenter)
            presenter.view = viewController

            return viewController
        }

        container.register(OnboardingRouterProtocol.self) { resolver in
            OnboardingRouter(resolver: resolver)
        }
        .inObjectScope(.container)
    }
}
