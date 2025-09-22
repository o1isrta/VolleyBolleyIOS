//
//  DistanceAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Swinject

final class DistanceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DistanceCalculatorProtocol.self) { _ in
            HaversineDistanceCalculator()
        }
    }
}
