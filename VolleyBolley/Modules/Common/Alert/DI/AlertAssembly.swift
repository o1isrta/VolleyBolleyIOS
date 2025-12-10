//
//  AlertAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.12.2025.
//

import Swinject

final class AlertAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ErrorPolicyEngineProtocol.self) { _ in
            ErrorPolicyEngine()
        }.inObjectScope(.container)

        container.register(AlertCoordinatorProtocol.self) { resolver in
            AlertCoordinator(
                root: resolver.safeResolve(RootViewControllerProviding.self),
                router: resolver.safeResolve(AppRouter.self)
            )
        }.inObjectScope(.container)
    }
}
