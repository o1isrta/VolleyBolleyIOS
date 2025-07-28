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
            let onbVC = OnboardingViewController()

            let interactor = resolver.resolve(OnboardingInteractorProtocol.self)!
            let appRouter = resolver.resolve(AppRouter.self)! // resolve вместо self.coordinator
            let router = OnboardingRouter(viewController: onbVC, coordinator: appRouter)
            let presenter = OnboardingPresenter(view: onbVC, interactor: interactor, router: router)

            onbVC.presenter = presenter
            return onbVC
        }

        container.register(OnboardingInteractorProtocol.self) { _ in
            OnboardingInteractor()
        }
    }
}
