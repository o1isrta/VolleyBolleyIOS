//
//  LocationAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Swinject

final class LocationAssembly: Assembly {

    func assemble(container: Container) {
        container.register(LocationServiceProtocol.self) { resolver in
            guard let environment = resolver.resolve(AppEnvironment.self) else {
                fatalError("Error: Failed to resolve AppEnvironment")
            }

            switch environment {
            case .mock:
                return MockLocationService(lat: 55.75, lon: 37.61) // Москва, например
            case .staging, .production:
                return LocationService()
            }
        }
        .inObjectScope(.container)
    }
}
