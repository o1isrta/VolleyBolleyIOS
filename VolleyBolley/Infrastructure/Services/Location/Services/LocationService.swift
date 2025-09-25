//
//  LocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    // MARK: - Private Properties

    private let locationManager = CLLocationManager()
    private var continuations: [CheckedContinuation<CLLocation, Error>] = []

    private(set) var lastKnownLocation: CLLocation?

    // MARK: - Init

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    // MARK: - Public Methods

    func requestLocation(forceUpdate: Bool = false, timeout: TimeInterval = 10) async throws -> CLLocation {
        // Вернём кеш если можно
        if !forceUpdate,
           let cached = lastKnownLocation,
           locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            return cached
        }

        return try await withThrowingTaskGroup(of: CLLocation.self) { group in
            // Запрос на локацию
            group.addTask { [weak self] in
                try await withCheckedThrowingContinuation { continuation in
                    self?.continuations.append(continuation)
                    self?.handleAuthorizationStatus(self?.locationManager.authorizationStatus ?? .notDetermined)
                }
            }

            // Таймаут
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw LocationError.timeout
            }

            // Вернём первый успешный результат
            guard let result = try await group.next() else {
                throw LocationError.failed
            }

            // Отменим остальные задачи (например, таймаут, если location уже пришла)
            group.cancelAll()
            return result
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            resolveAll(.failure(LocationError.notFound))
            return
        }

        lastKnownLocation = location
        resolveAll(.success(location))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let clError = error as? CLError
        let mapped: LocationError

        switch clError?.code {
        case .locationUnknown:
            mapped = .notFound
        case .denied:
            mapped = .denied
        default:
            mapped = .failed
        }

        resolveAll(.failure(mapped))
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAuthorizationStatus(manager.authorizationStatus)
    }

    // MARK: - Private Methods

    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied:
            resolveAll(.failure(LocationError.denied))
        case .restricted:
            resolveAll(.failure(LocationError.restricted))
        @unknown default:
            resolveAll(.failure(LocationError.failed))
        }
    }

    private func resolveAll(_ result: Result<CLLocation, Error>) {
        continuations.forEach { continuation in
            switch result {
            case .success(let location):
                continuation.resume(returning: location)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
        continuations.removeAll()
    }
}
