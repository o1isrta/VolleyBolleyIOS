//
//  WeatherAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.09.2025.
//

import Swinject

final class WeatherAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DefaultWeatherServiceProtocol.self) { resolver in
            let environment = resolver.resolve(AppEnvironment.self)!
            switch environment {
            case .mock, .staging:
                return MockWeatherService()
            case .production:
                return DefaultWeatherService()
            }
        }.inObjectScope(.container)

        container.register(WeatherRepositoryProtocol.self) { resolver in
            guard let service = resolver.resolve(DefaultWeatherServiceProtocol.self) else {
                fatalError("Error: Failed to resolve DefaultWeatherServiceProtocol")
            }
            return WeatherRepository(service: service)
        }.inObjectScope(.container)
    }
}
