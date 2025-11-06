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
                    resolver.safeResolve(AuthViewController.self)
                },
                userRegFactory: {
                    resolver.safeResolve(UserRegViewProtocol.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(AuthViewController.self) { resolver in
            MainActor.assumeIsolated {
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

                return view
            }
        }
    }
}
