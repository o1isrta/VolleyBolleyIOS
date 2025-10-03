//
//  UserSessionAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class UserSessionAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserSessionServiceProtocol.self) { resolver in
            guard let storage = resolver.resolve(SettingsStorageProtocol.self) else {
                fatalError("Failed to resolve SettingsStorageProtocol")
            }

            return UserSessionService(storage: storage)
        }
        .inObjectScope(.container)
    }
}
