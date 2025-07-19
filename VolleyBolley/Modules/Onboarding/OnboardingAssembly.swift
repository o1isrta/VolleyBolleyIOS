//
//  OnboardingAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

class OnboardingAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(OnboardingViewController.self) { _ in
            let viewController = OnboardingViewController()
            // здесь можно будет позже добавить presenter/interactor
            return viewController
        }

        container.register(OnboardingRouterProtocol.self) { resolver in
            OnboardingRouter(resolver: resolver)
        }
        .inObjectScope(.transient)
    }
}
