//
//  TokenStorageAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class TokenStorageAssembly: Assembly {

    func assemble(container: Container) {
        container.register(TokenStorageProtocol.self) { _ in
            TokenStorage.shared
        }.inObjectScope(.container)
    }
}
