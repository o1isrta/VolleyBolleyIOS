//
//  SettingsStorageAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class SettingsStorageAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SettingsStorageProtocol.self) { _ in
            UserDefaultsStorage()
        }
        .inObjectScope(.container)
    }
}
