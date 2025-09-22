//
//  DistanceCalculatorProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

protocol DistanceCalculatorProtocol {
    /// Расстояние в метрах
    func distance(from origin: Coordinates, to destination: Coordinates) -> Double

    /// Ближайший объект
    func nearest<T>(
        from origin: Coordinates,
        in objects: [T],
        location: (T) -> Coordinates
    ) -> T?
}
