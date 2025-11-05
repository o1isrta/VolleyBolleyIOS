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
                    resolver.safeResolve(AuthViewProtocol.self)
                },
                userRegFactory: {
                    resolver.safeResolve(UserRegViewProtocol.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(AuthViewProtocol.self) { resolver in
            let googleAuthService = resolver.safeResolve(GoogleAuthServiceProtocol.self)
            let firebaseAuthService = resolver.safeResolve(FirebaseAuthServiceProtocol.self)
            let authRepository = resolver.safeResolve(AuthRepositoryProtocol.self)

            let router = resolver.safeResolve(AuthRouterProtocol.self)
            let interactor = AuthInteractor(
                googleAuthService: googleAuthService,
                firebaseAuthService: firebaseAuthService,
                authRepository: authRepository,
                router: router
            )
            let presenter = AuthPresenter(
                interactor: interactor,
                router: router,
                //                finishAuthFlow: { [weak router] in
                //                    router?.finishAuth()
                //                }
            )
            let view = AuthViewController(presenter: presenter)

            interactor.presenter = presenter
            presenter.view = view

            return view
        }
    }
}
