//
//  WeatherError.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 12.09.2025.
//

import Foundation

enum WeatherError: Error {
    case serviceUnavailable
    case invalidData
    case unknown(Error)
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serviceUnavailable:
            return "Weather service is unavailable."
        case .invalidData:
            return "Received invalid weather data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
