//
//  SortCourtsByDistanceUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

protocol CourtsWithDistanceUseCaseProtocol {
    func execute(userLocation: Coordinates, courts: [Court]) -> [CourtWithDistance]
}

final class SortCourtsByDistanceUseCase: CourtsWithDistanceUseCaseProtocol {

    // MARK: - Private Properties

    private let distanceCalculator: DistanceCalculatorProtocol

    // MARK: - Initializers

    init(distanceCalculator: DistanceCalculatorProtocol) {
        self.distanceCalculator = distanceCalculator
    }

    // MARK: - Public Methods

    /// Возвращает массив CourtWithDistance, отсортированный по расстоянию
    func execute(userLocation: Coordinates, courts: [Court]) -> [CourtWithDistance] {
        let courtsWithDistance = courts.map { court in
            let distanceMeters = distanceCalculator.distance(from: userLocation, to: court.coordinates)
            let distanceKm = (distanceMeters / 1000).rounded(toPlaces: 1)
            return CourtWithDistance(court: court, distanceKm: distanceKm)
        }
        return courtsWithDistance.sorted { $0.distanceKm < $1.distanceKm }
    }
}

private extension Double {
    /// Округление до N знаков после запятой
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
