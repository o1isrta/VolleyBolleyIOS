//
//  MockLocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

final class MockLocationService: LocationServiceProtocol {

    var lastKnownLocation: CLLocation?

    private let mockedLocation: CLLocation

    init(lat: Double = 7.84927, lon: Double =  98.29500) {
        self.mockedLocation = CLLocation(latitude: lat, longitude: lon)
    }

    func requestLocation(forceUpdate: Bool) async throws -> CLLocation {
        mockedLocation
    }
}
