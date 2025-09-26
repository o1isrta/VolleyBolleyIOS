//
//  LocationAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Swinject

final class LocationAssembly: Assembly {

    func assemble(container: Container) {
        container.register(LocationServiceProtocol.self) { _ in
            guard let environment = container.resolve(AppEnvironment.self) else {
                fatalError("Error: Failed to resolve AppEnvironment")
            }

            switch environment {
            case .mock:
                return MockLocationService()
            case .production, .staging:
                return LocationService()
            }
        }
        .inObjectScope(.container)

        container.register(LocationRepositoryProtocol.self) { resolver in
            guard let service = resolver.resolve(LocationServiceProtocol.self) else {
                fatalError("Error: Failed to resolve LocationServiceProtocol")
            }

            return LocationRepository(service: service)
        }
        .inObjectScope(.container)
    }
}
