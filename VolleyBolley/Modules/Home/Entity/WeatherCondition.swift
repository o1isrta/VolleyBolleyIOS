//
//  WeatherCondition.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.08.2025.
//

import UIKit

enum WeatherCondition {
    case clearDay
    case clearNight
    case cloudy
    case rain
    case thunderstorm
    case snow
    case fog
    case unknown
}

extension WeatherCondition {
    var symbolName: String {
        switch self {
        case .clearDay: return "sun.max"
        case .clearNight: return "moon.stars"
        case .cloudy: return "cloud"
        case .rain: return "cloud.rain"
        case .thunderstorm: return "cloud.bolt.rain"
        case .snow: return "cloud.snow"
        case .fog: return "cloud.fog"
        case .unknown: return "questionmark"
        }
    }

    var icon: UIImage? {
        return UIImage(systemName: symbolName)
    }

    init(apiValue: String) {
        switch apiValue.lowercased() {
        case "clear_day": self = .clearDay
        case "clear_night": self = .clearNight
        case "clouds": self = .cloudy
        case "rain": self = .rain
        case "thunderstorm": self = .thunderstorm
        case "snow": self = .snow
        case "fog", "mist": self = .fog
        default: self = .unknown
        }
    }
}
