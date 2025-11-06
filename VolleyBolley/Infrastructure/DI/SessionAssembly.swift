//
//  SessionAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Swinject

final class SessionAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SecureStorageProtocol.self) { _ in
            KeychainStorage()
        }
        .inObjectScope(.container)

        container.register(SessionRepositoryProtocol.self) { resolver in
            let storage = resolver.safeResolve(SecureStorageProtocol.self)

            return SessionRepository(storage: storage)
        }
        .inObjectScope(.container)
    }
}
