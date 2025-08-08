//
//  LocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    private var onLocationUpdate: ((CLLocation) -> Void)?

    func requestLocation(completion: @escaping (CLLocation?) -> Void) {
        self.onLocationUpdate = completion

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            onLocationUpdate?(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}

