//
//  LocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

protocol LocationServiceProtocol {
    func requestLocation(forceUpdate: Bool) async throws -> CLLocation
    var lastKnownLocation: CLLocation? { get }
}

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    // MARK: - Private Properties

    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation, Error>?

    private(set) var lastKnownLocation: CLLocation?

    // MARK: - Initializers

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    // MARK: - Public Methods

    func requestLocation(forceUpdate: Bool = false) async throws -> CLLocation {
        if !forceUpdate,
           let cached = lastKnownLocation,
           locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            return cached
        }

        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            handleAuthorizationStatus(locationManager.authorizationStatus)
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            continuation?.resume(throwing: LocationError.notFound)
            continuation = nil
            return
        }
        continuation?.resume(returning: location)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        continuation?.resume(throwing: LocationError.failed)
        continuation = nil
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
            continuation?.resume(throwing: LocationError.denied)
            continuation = nil
        case .restricted:
            continuation?.resume(throwing: LocationError.restricted)
            continuation = nil
        @unknown default:
            continuation?.resume(throwing: LocationError.failed)
            continuation = nil
        }
    }
}
