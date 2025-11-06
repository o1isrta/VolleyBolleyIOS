//
//  MainAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class MainAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(MainRouterProtocol.self) { resolver in
            MainRouter(
                homeRouter: resolver.safeResolve(HomeRouterProtocol.self),
                myGamesRouter: resolver.safeResolve(MyGamesRouterProtocol.self),
                profileRouter: resolver.safeResolve(ProfileRouterProtocol.self)
            )
        }
        .inObjectScope(.container)
    }
}
