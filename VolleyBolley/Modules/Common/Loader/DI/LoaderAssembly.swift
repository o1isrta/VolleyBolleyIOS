//
//  LoaderAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.12.2025.
//

import Swinject

final class LoaderAssembly: Assembly {

    func assemble(container: Container) {

        container.register(LoaderCoordinatorProtocol.self) { resolver in
            LoaderCoordinator(
                root: resolver.safeResolve(RootViewControllerProviding.self),
                router: resolver.safeResolve(AppRouter.self)
            )
        }.inObjectScope(.container)
    }
}
