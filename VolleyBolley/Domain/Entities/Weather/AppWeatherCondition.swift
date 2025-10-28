//
//  AppWeatherCondition.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.09.2025.
//

import UIKit

enum AppWeatherCondition {
    case clear, mostlyClear, partlyCloudy, mostlyCloudy, cloudy
    case foggy, smoky, windy, drizzle, rain, heavyRain
    case thunderstorms, snow, flurries, blizzard, sleet, hail
    case freezingRain, hurricane, blowingDust, blowingSnow, breezy
    case freezingDrizzle, frigid, haze, heavySnow, hot
    case isolatedThunderstorms, scatteredThunderstorms, strongStorms
    case sunFlurries, sunShowers, tropicalStorm, wintryMix
    case unknown
}

extension AppWeatherCondition {
    var icon: UIImage? {
        switch self {
        case .clear: return UIImage(systemName: "sun.max")
        case .mostlyClear: return UIImage(systemName: "sun.min")
        case .partlyCloudy: return UIImage(systemName: "cloud.sun")
        case .mostlyCloudy: return UIImage(systemName: "cloud.sun.fill")
        case .cloudy: return UIImage(systemName: "cloud")
        case .foggy: return UIImage(systemName: "cloud.fog")
        case .smoky: return UIImage(systemName: "smoke")
        case .windy: return UIImage(systemName: "wind")
        case .drizzle: return UIImage(systemName: "cloud.drizzle")
        case .rain: return UIImage(systemName: "cloud.rain")
        case .heavyRain: return UIImage(systemName: "cloud.heavyrain")
        case .thunderstorms: return UIImage(systemName: "cloud.bolt.rain")
        case .snow: return UIImage(systemName: "cloud.snow")
        case .flurries: return UIImage(systemName: "wind.snow")
        case .blizzard: return UIImage(systemName: "snowflake")
        case .sleet: return UIImage(systemName: "cloud.sleet")
        case .hail: return UIImage(systemName: "cloud.hail")
        case .freezingRain: return UIImage(systemName: "cloud.hail")
        case .hurricane: return UIImage(systemName: "hurricane")
        case .blowingDust: return UIImage(systemName: "sun.dust")
        case .blowingSnow: return UIImage(systemName: "wind.snow")
        case .breezy: return UIImage(systemName: "wind")
        case .freezingDrizzle: return UIImage(systemName: "cloud.sleet")
        case .frigid: return UIImage(systemName: "thermometer.snowflake")
        case .haze: return UIImage(systemName: "sun.haze")
        case .heavySnow: return UIImage(systemName: "cloud.snow.fill")
        case .hot: return UIImage(systemName: "thermometer.sun")
        case .isolatedThunderstorms,
             .scatteredThunderstorms,
             .strongStorms: return UIImage(systemName: "cloud.bolt.rain")
        case .sunFlurries: return UIImage(systemName: "cloud.snow")
        case .sunShowers: return UIImage(systemName: "cloud.sun.rain")
        case .tropicalStorm: return UIImage(systemName: "tropicalstorm")
        case .wintryMix: return UIImage(systemName: "cloud.sleet")
        case .unknown: return UIImage(systemName: "questionmark")
        }
    }
}
