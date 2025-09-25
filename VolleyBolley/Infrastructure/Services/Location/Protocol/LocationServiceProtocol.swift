//
//  LocationServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 25.09.2025.
//

import CoreLocation

protocol LocationServiceProtocol {
    func requestLocation(forceUpdate: Bool, timeout: TimeInterval) async throws -> CLLocation
    var lastKnownLocation: CLLocation? { get }
}
