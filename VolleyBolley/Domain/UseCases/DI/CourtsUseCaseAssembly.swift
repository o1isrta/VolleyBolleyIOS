//
//  CourtsUseCaseAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Swinject

final class CourtsUseCaseAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CourtsUseCaseProtocol.self) { resolver in
            guard
                let courtsRepository = resolver.resolve(CourtsRepositoryProtocol.self)
            else {
                fatalError("Error: Failed to register NearestCourtWithWeatherUseCase")
            }

            return NearestCourtUseCase(courtRepository: courtsRepository)
        }
    }
}
