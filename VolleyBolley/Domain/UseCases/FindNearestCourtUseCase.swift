//
//  FindNearestCourtUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

protocol FindNearestCourtUseCaseProtocol {
    func execute(userLocation: Coordinates, courts: [Court]) -> Court?
}

final class FindNearestCourtUseCase: FindNearestCourtUseCaseProtocol {

    // MARK: - Private Properties

    private let distanceCalculator: DistanceCalculatorProtocol

    // MARK: - Initializers

    init(distanceCalculator: DistanceCalculatorProtocol) {
        self.distanceCalculator = distanceCalculator
    }

    // MARK: - Public Methods

    func execute(userLocation: Coordinates, courts: [Court]) -> Court? {

        return distanceCalculator.nearest(
            from: userLocation,
            in: courts,
            location: { $0.coordinates }
        )
    }
}
