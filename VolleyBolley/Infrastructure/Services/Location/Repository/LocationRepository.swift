//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

protocol LocationRepositoryProtocol {
    func getPlayerLocation(forceUpdate: Bool) async throws -> GeoPoint
    func getCachedPlayerLocation() -> GeoPoint?
}

final class LocationRepository: LocationRepositoryProtocol {

    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    func getPlayerLocation(forceUpdate: Bool = false) async throws -> GeoPoint {
        let location = try await service.requestLocation(forceUpdate: forceUpdate)
        return GeoPoint(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }

    func getCachedPlayerLocation() -> GeoPoint? {
        guard let cached = service.lastKnownLocation else { return nil }
        return GeoPoint(
            lat: cached.coordinate.latitude,
            lon: cached.coordinate.longitude
        )
    }
}
