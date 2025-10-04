//
//  EnvironmentAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

struct EnvironmentAssembly: Assembly {
    func assemble(container: Container) {
        let environment = AppEnvironment.fromPlist()
        container.register(AppEnvironment.self) { _ in
            environment
        }.inObjectScope(.container)
    }
}
