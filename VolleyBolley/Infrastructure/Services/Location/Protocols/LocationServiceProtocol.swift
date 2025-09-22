//
//  LocationServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import CoreLocation

protocol LocationServiceProtocol {
    func requestLocation(forceUpdate: Bool) async throws -> CLLocation
    var lastKnownLocation: CLLocation? { get }
}
