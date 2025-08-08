//
//  WeatherServiceProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

import Foundation
import CoreLocation
import WeatherKit // Оставим, чтобы интерфейс совпадал

protocol WeatherServiceProtocol {
    func getCurrentWeather(for location: CLLocation) async throws -> CurrentWeather
}
