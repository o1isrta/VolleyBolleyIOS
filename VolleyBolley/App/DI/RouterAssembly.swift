//
//  RouterAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import Swinject
import UIKit

final class RouterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppRouter.self) { resolver in
            guard let window = resolver.resolve(UIWindow.self),
                  let userSessionService = resolver.resolve(UserSessionServiceProtocol.self) else {
                fatalError("Failed to resolve dependencies for AppRouter")
            }

            return AppRouter(
                window: window,
                userSessionService: userSessionService,
                resolver: resolver
            )
        }.inObjectScope(.container)
    }
}
