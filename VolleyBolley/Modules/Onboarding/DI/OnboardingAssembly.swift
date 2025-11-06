//
//  OnboardingAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class OnboardingAssembly: Assembly {

    func assemble(container: Container) {
        container.register(OnboardingRouterProtocol.self) { resolver in
            OnboardingRouter(viewControllerFactory: {
                resolver.safeResolve(OnboardingViewProtocol.self)
            })
        }
        .inObjectScope(.container)

        container.register(OnboardingViewProtocol.self) { resolver in
            let onboardingRepository = resolver.resolve(OnboardingRepositoryProtocol.self)!
            let router = resolver.resolve(OnboardingRouterProtocol.self)!

            let interactor = OnboardingInteractor(onboardingRepository: onboardingRepository)
            let presenter = OnboardingPresenter(
                interactor: interactor,
                finishOnboardingFlow: { [weak router] in
                    router?.finishOnboarding()
                }
            )

            let view = OnboardingViewController(presenter: presenter)
            presenter.view = view

            return view
        }
    }
}
