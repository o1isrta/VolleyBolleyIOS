//
//  LocationRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import Foundation

final class LocationRepository: LocationRepositoryProtocol {

    // MARK: - Private properties

    private let service: LocationServiceProtocol

    // MARK: - Initializers

    init(service: LocationServiceProtocol) {
        self.service = service
    }

    // MARK: - Public methods

    func getPlayerLocation(forceUpdate: Bool = false, timeout: TimeInterval = 10) async throws -> Coordinates {
        do {
            let location = try await service.requestLocation(forceUpdate: forceUpdate, timeout: timeout)
            return Coordinates(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        } catch let error as CoreLocationError {
            throw mapError(error)
        } catch {
            throw LocationError.unavailable
        }
    }

    func getCachedPlayerLocation() -> Coordinates? {
        guard let cached = service.lastKnownLocation else { return nil }
        return Coordinates(
            latitude: cached.coordinate.latitude,
            longitude: cached.coordinate.longitude
        )
    }

    // MARK: - Private methods

    private func mapError(_ error: CoreLocationError) -> LocationError {
        switch error {
        case .denied:
            return .permissionDenied
        case .restricted:
            return .restricted
        case .timeout, .failed:
            return .unavailable
        case .notFound:
            return .notFound
        case .notDetermined:
            return .unavailable
        }
    }
}
