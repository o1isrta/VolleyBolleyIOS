//
//  MockLocationService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation

final class MockLocationService: LocationServiceProtocol {
    private let mockedLocation: CLLocation

    init(lat: Double, lon: Double) {
        self.mockedLocation = CLLocation(latitude: lat, longitude: lon)
    }

    func requestLocation(completion: @escaping (CLLocation?) -> Void) {
        completion(mockedLocation)
    }
}
