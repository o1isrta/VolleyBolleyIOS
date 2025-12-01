//
//  UserSessionAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class UserSessionAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserSessionServiceProtocol.self) { _ in
            return UserSessionService()
        }
        .inObjectScope(.container)
    }
}
