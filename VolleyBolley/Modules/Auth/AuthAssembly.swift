//
//  AuthAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class AuthAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(AuthViewController.self) { _ in
            let viewController = AuthViewController()

            return viewController
        }

        container.register(AuthRouterProtocol.self) { resolver in
            AuthRouter(resolver: resolver)
        }
        .inObjectScope(.transient)
    }
}
