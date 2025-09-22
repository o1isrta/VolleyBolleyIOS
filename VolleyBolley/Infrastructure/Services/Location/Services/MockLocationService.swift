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

    init(
        latitude: Double = 7.84927,
        longitude: Double =  98.29500
    ) {
        self.mockedLocation = CLLocation(latitude: latitude, longitude: longitude)
    }

    func requestLocation(forceUpdate: Bool) async throws -> CLLocation {
        mockedLocation
    }
}
