//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

final class LocationRepository: LocationRepositoryProtocol {

    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    func getPlayerLocation(forceUpdate: Bool = false) async throws -> Coordinates {
        let location = try await service.requestLocation(forceUpdate: forceUpdate)
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
