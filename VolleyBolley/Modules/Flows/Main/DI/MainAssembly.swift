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
        container.register(MainAppRouterProtocol.self) { resolver in
            MainAppRouter(resolver: resolver)
        }
        .inObjectScope(.container)
    }
}
