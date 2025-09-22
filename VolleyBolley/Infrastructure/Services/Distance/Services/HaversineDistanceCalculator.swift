//
//  HaversineDistanceCalculator.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 20.09.2025.
//

import Foundation

final class HaversineDistanceCalculator: DistanceCalculatorProtocol {

    func distance(from origin: Coordinates, to destination: Coordinates) -> Double {
        let earthRadiusMeters = 6_371_000.0

        let deltaLatitude = (destination.latitude - origin.latitude).degreesToRadians
        let deltaLongitude = (destination.longitude - origin.longitude).degreesToRadians

        let originLatitudeRad = origin.latitude.degreesToRadians
        let destinationLatitudeRad = destination.latitude.degreesToRadians

        let haversine = sin(deltaLatitude / 2) * sin(deltaLatitude / 2)
                      + cos(originLatitudeRad) * cos(destinationLatitudeRad)
                      * sin(deltaLongitude / 2) * sin(deltaLongitude / 2)

        let centralAngle = 2 * atan2(sqrt(haversine), sqrt(1 - haversine))
        return earthRadiusMeters * centralAngle
    }

    func nearest<T>(
        from origin: Coordinates,
        in objects: [T],
        location: (T) -> Coordinates
    ) -> T? {
        objects.min { first, second in
            distance(from: origin, to: location(first))
            < distance(from: origin, to: location(second))
        }
    }
}

private extension Double {
    var degreesToRadians: Double { self * .pi / 180 }
}
