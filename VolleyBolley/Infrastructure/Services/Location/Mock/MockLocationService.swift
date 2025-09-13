//
//  MockLocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

final class MockLocationService: LocationServiceProtocol {

    private let mockedLocation: CLLocation

    init(lat: Double = 7.84927, lon: Double =  98.29500) {
        self.mockedLocation = CLLocation(latitude: lat, longitude: lon)
    }

    func requestLocation() async throws -> CLLocation {
        mockedLocation
    }
}
