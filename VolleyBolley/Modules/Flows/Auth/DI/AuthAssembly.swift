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
                window: resolver.resolve(UIWindow.self)!,
                viewControllerFactory: {
                    resolver.resolve(AuthViewProtocol.self)!
                },
                userRegFactory: {
                    resolver.resolve(UserRegViewProtocol.self)!
                }
            )
        }
        .inObjectScope(.container)

        container.register(AuthViewProtocol.self) { resolver in
            let googleAuthService = resolver.resolve(GoogleAuthServiceProtocol.self)!
            let firebaseAuthService = resolver.resolve(FirebaseAuthServiceProtocol.self)!
            let authRepository = resolver.resolve(AuthRepositoryProtocol.self)!
            let sessionRepository = resolver.resolve(SessionRepositoryProtocol.self)!
            let router = resolver.resolve(AuthRouterProtocol.self)!
            let interactor = AuthInteractor(
                googleAuthService: googleAuthService,
                firebaseAuthService: firebaseAuthService,
                authRepository: authRepository,
                sessionRepository: sessionRepository,
                router: router
            )
            let presenter = AuthPresenter(
                interactor: interactor,
                router: router
            )
            let view = AuthViewController(presenter: presenter)

            interactor.presenter = presenter
            presenter.view = view

            return view
        }
    }
}
