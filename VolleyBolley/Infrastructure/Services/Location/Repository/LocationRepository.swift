//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

final class LocationRepository: LocationRepositoryProtocol {

    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    func getPlayerLocation(forceUpdate: Bool = false, timeout: TimeInterval = 10) async throws -> Coordinates {
        let location = try await service.requestLocation(forceUpdate: forceUpdate, timeout: timeout)
        return Coordinates(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }

    func getCachedPlayerLocation() -> Coordinates? {
        guard let cached = service.lastKnownLocation else { return nil }
        return Coordinates(
            latitude: cached.coordinate.latitude,
            longitude: cached.coordinate.longitude
        )
    }
}
