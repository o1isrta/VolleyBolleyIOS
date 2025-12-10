//
//  UIShellAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Swinject

final class UIShellAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UIShellProtocol.self) { resolver in
            UIShell(
                policy: resolver.safeResolve(ErrorPolicyEngineProtocol.self),
                alertCoordinator: resolver.safeResolve(AlertCoordinatorProtocol.self),
                loaderCoordinator: resolver.safeResolve(LoaderCoordinatorProtocol.self)
            )
        }.inObjectScope(.container)
    }
}
