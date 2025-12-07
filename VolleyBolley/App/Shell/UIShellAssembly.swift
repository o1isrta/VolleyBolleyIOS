//
//  UIShellAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Swinject

final class UIShellAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ErrorPolicyEngineProtocol.self) { _ in
            ErrorPolicyEngine()
        }.inObjectScope(.container)

        container.register(AlertCoordinatorProtocol.self) { resolver in
            AlertCoordinator(
                root: resolver.safeResolve(RootViewControllerProviding.self),
                router: resolver.safeResolve(AppRouter.self),
                alertVC: AlertViewController()
            )
        }.inObjectScope(.container)

        container.register(UIShellProtocol.self) { resolver in
            UIShell(
                policy: resolver.safeResolve(ErrorPolicyEngineProtocol.self),
                alertCoordinator: resolver.safeResolve(AlertCoordinatorProtocol.self)
            )
        }.inObjectScope(.container)
    }
}
