//
//  SharedServicesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

/// An assembly for registering shared application services with the Swinject dependency injection container.
/// 
/// `SharedServicesAssembly` centralizes the registration of singleton services that are shared across the app.
/// The assembly is intended to be used in applications that rely on Swinject for dependency injection.
/// 
/// ## Registered Services
/// - `SettingsStorageProtocol`: Registers a `UserDefaultsStorage` instance as a singleton.
/// - `UserSessionServiceProtocol`: Registers a `DefaultUserSessionService`,
/// injected with the shared `SettingsStorageProtocol` instance, as a singleton.
///
/// Registration is performed with `.inObjectScope(.container)` to ensure each service is a shared singleton.
/// 
/// - Warning: If resolving `SettingsStorageProtocol` fails when registering `UserSessionServiceProtocol`, a runtime
///   `fatalError` is triggered.
/// 
/// Usage:
/// ```swift
/// let container = Container()
/// let assembly = SharedServicesAssembly()
/// assembly.assemble(container: container)
/// ```
final class SharedServicesAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SettingsStorageProtocol.self) { _ in
            UserDefaultsStorage()
        }
        .inObjectScope(.container)

        container.register(UserSessionServiceProtocol.self) { resolver in
            guard let storage = resolver.resolve(SettingsStorageProtocol.self) else {
                fatalError("Error: Failed to resolve SettingsStorageProtocol")
            }
            return DefaultUserSessionService(storage: storage)
        }
        .inObjectScope(.container)
        
        container.register(AppRouter.self) { resolver in
            guard let window = resolver.resolve(UIWindow.self) else {
                fatalError("Error: Failed to resolve UIWindow")
            }
            guard let userSessionService = resolver.resolve(UserSessionServiceProtocol.self) else {
                fatalError("Error: Failed to resolve UserSessionServiceProtocol")
            }
            return AppRouter(window: window, userSessionService: userSessionService, resolver: resolver)
        }
        .inObjectScope(.container)
    }
}
