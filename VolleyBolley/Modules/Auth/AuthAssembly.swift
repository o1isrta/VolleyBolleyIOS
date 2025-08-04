//
//  AuthAssembly.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import Swinject

final class AuthAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AuthViewController.self) { resolver in
            let authVC = AuthViewController()

            let interactor = AuthorizationInteractor()
            let appRouter = resolver.resolve(AppRouter.self)! // resolve вместо self.coordinator
            let router = AuthRouter(viewController: authVC, coordinator: appRouter)
            let presenter = AuthorizationPresenter(view: authVC, interactor: interactor, router: router)

            interactor.presenter = presenter
            authVC.presenter = presenter
            return authVC
        }

        container.register(AuthInteractorProtocol.self) { _ in
            AuthorizationInteractor()
        }
    }
}
