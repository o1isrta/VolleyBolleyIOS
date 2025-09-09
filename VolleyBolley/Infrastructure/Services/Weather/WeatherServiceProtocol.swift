//
//  WeatherServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import CoreLocation
import Foundation
import WeatherKit

protocol WeatherServiceProtocol {
    func getCurrentWeather(for location: CLLocation) async throws -> CurrentWeather
}
