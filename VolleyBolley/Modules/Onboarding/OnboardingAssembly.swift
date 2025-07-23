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
            let vc = OnboardingViewController()

            let interactor = resolver.resolve(OnboardingInteractorProtocol.self)!
            let appRouter = resolver.resolve(AppRouter.self)! // resolve вместо self.coordinator
            let router = OnboardingRouter(viewController: vc, coordinator: appRouter)
            let presenter = OnboardingPresenter(view: vc, interactor: interactor, router: router)

            vc.presenter = presenter
            return vc
        }

        container.register(OnboardingInteractorProtocol.self) { _ in
            OnboardingInteractor()
        }
    }
}
