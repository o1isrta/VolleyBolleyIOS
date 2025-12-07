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
                    resolver.safeResolve(UserRegViewController.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(AuthViewController.self) { resolver in
            MainActor.assumeIsolated {
                let googleAuthService = resolver.safeResolve(GoogleOAuthServiceProtocol.self)
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
                    uiShell: resolver.safeResolve(UIShellProtocol.self)
                )
                let view = AuthViewController(presenter: presenter)

                return view
            }
        }
    }
}
