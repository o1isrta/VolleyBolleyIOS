//
//  DIContainer.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

/// `DIContainer` is a singleton responsible for setting up and providing access to the application's dependency injection container using Swinject.
/// 
/// - Initialization:
///   Call `DIContainer.initialize(window:)` early in the app lifecycle to configure the global container. 
///   This method is safe to call only once per launch; subsequent calls will trigger a precondition failure.
///   Access the shared instance through the `DIContainer.shared` property. Accessing before initialization will cause a runtime fatal error.
/// 
/// - Usage:
///   Use the `resolver` property to resolve registered dependencies throughout the app.
///   The container is configured with a set of assemblies that register services, coordinators, and view models for each app module.
/// 
/// - Properties:
///   - `assembler`: The Swinject `Assembler` used to assemble the application's dependency graph.
///   - `resolver`: A convenience property to access the root `Resolver`.
///
/// - Example:
///   ```swift
///   DIContainer.initialize(window: window)
///   let container = DIContainer.shared
///   let someService = container.resolver.resolve(SomeServiceType.self)
///   ```
final class DIContainer {

    // MARK: - Public Properties

    let assembler: Assembler
    var resolver: Resolver { assembler.resolver }

    static var shared: DIContainer {
        guard let instance = _shared else {
            fatalError("DIContainer.shared accessed before being initialized. Call DIContainer.initialize(window:) first.")
        }
        return instance
    }

    // MARK: - Private Properties

    private static var _shared: DIContainer?

    // MARK: - Initializers

    init(window: UIWindow) {
        assembler = Assembler(
            [
                AppAssembly(window: window),
                SharedServicesAssembly(),
                OnboardingAssembly(),
                AuthAssembly(),
                MainAssembly(),
                HomeAssembly(),
                MyGamesAssembly(),
                ProfileAssembly()
            ]
        )
    }

    // MARK: - Public Methods

    static func initialize(window: UIWindow) {
        precondition(_shared == nil, "DIContainer already initialized")
        _shared = DIContainer(window: window)
    }
}
