//
//  GamesUseCaseAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Swinject

final class GamesUseCaseAssembly: Assembly {

    func assemble(container: Container) {
        container.register(GamesUseCaseProtocol.self) { resolver in
            guard
                let gamesRepository = resolver.resolve(GamesRepositoryProtocol.self)
            else {
                fatalError("Error: Failed to register NearbyGamesUseCase")
            }

            return GamesUseCase(gamesRepository: gamesRepository)
        }
    }
}
