//
//  GoogleAuthAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 18.10.2025.
//

import Swinject

final class GoogleAuthAssembly: Assembly {

    func assemble(container: Container) {
        container.register(GoogleOAuthServiceProtocol.self) { _ in
            GoogleOAuthService()
        }
    }
}
