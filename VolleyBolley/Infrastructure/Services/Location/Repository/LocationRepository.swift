//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.08.2025.
//

protocol LocationRepositoryProtocol {
    func getPlayerLocation() async throws -> GeoPoint
}

final class LocationRepository: LocationRepositoryProtocol {

    private let service: LocationServiceProtocol

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    func getPlayerLocation() async throws -> GeoPoint {
        let location = try await service.requestLocation()

        return GeoPoint(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }
}
