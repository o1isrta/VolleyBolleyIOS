//
//  SettingsAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class SettingsAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SettingsStorageProtocol.self) { _ in
            SettingsStorage()
        }
        .inObjectScope(.container)

        container.register(OnboardingRepositoryProtocol.self) { resolver in
            let storage = resolver.resolve(SettingsStorageProtocol.self)!

            return OnboardingRepository(storage: storage)
        }
        .inObjectScope(.container)
    }
}
