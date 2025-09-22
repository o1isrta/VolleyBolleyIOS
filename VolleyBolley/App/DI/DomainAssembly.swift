//
//  DomainAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import Swinject

final class DomainAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FindNearestCourtUseCaseProtocol.self) { resolver in
            guard
                let distanceCalculator = resolver.resolve(DistanceCalculatorProtocol.self)
            else {
                fatalError("Failed to resolve dependencies for FindNearestCourtUseCase")
            }

            return FindNearestCourtUseCase(distanceCalculator: distanceCalculator)
        }
    }
}
