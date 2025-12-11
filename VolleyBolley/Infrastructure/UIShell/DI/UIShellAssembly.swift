//
//  UIShellAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Swinject
import UIKit

final class UIShellAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UIShellProtocol.self) { resolver in
            UIShell(
                policy: resolver.safeResolve(ErrorPolicyEngineProtocol.self),
                mapper: resolver.safeResolve(AlertMapperProtocol.self),
                alertCoordinator: resolver.safeResolve(AlertCoordinatorProtocol.self),
                loaderCoordinator: resolver.safeResolve(LoaderCoordinatorProtocol.self)
            )
        }.inObjectScope(.container)

        container.register(RootViewControllerProviding.self) { resolver in
            DefaultRootViewControllerProvider(
                window: resolver.safeResolve(UIWindow.self)
            )
        }.inObjectScope(.container)

        container.register(ErrorPolicyEngineProtocol.self) { _ in
            ErrorPolicyEngine()
        }.inObjectScope(.container)

        container.register(AlertCoordinatorProtocol.self) { resolver in
            AlertCoordinator(
                root: resolver.safeResolve(RootViewControllerProviding.self),
                router: resolver.safeResolve(AppRouter.self)
            )
        }.inObjectScope(.container)

        container.register(AlertMapperProtocol.self) { _ in
            AlertMapper()
        }

        container.register(LoaderCoordinatorProtocol.self) { resolver in
            LoaderCoordinator(
                root: resolver.safeResolve(RootViewControllerProviding.self),
                router: resolver.safeResolve(AppRouter.self)
            )
        }.inObjectScope(.container)
    }
}
