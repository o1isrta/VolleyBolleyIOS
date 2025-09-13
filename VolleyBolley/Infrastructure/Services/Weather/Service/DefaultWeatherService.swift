//
//  WeatherService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.09.2025.
//

import CoreLocation
import WeatherKit

protocol DefaultWeatherServiceProtocol {
    func fetchCurrentWeather(for geoPoint: GeoPoint) async throws -> AppWeather
}

final class DefaultWeatherService: DefaultWeatherServiceProtocol {

    private let service = WeatherKit.WeatherService()

    private let conditionMap: [WeatherKit.WeatherCondition: AppWeatherCondition] = [
        .clear: .clear,
        .mostlyClear: .mostlyClear,
        .partlyCloudy: .partlyCloudy,
        .mostlyCloudy: .mostlyCloudy,
        .cloudy: .cloudy,
        .foggy: .foggy,
        .smoky: .smoky,
        .windy: .windy,
        .drizzle: .drizzle,
        .rain: .rain,
        .heavyRain: .heavyRain,
        .thunderstorms: .thunderstorms,
        .snow: .snow,
        .flurries: .flurries,
        .blizzard: .blizzard,
        .sleet: .sleet,
        .hail: .hail,
        .freezingRain: .freezingRain,
        .hurricane: .hurricane,
        .blowingDust: .blowingDust,
        .blowingSnow: .blowingSnow,
        .breezy: .breezy,
        .freezingDrizzle: .freezingDrizzle,
        .frigid: .frigid,
        .haze: .haze,
        .heavySnow: .heavySnow,
        .hot: .hot,
        .isolatedThunderstorms: .isolatedThunderstorms,
        .scatteredThunderstorms: .scatteredThunderstorms,
        .strongStorms: .strongStorms,
        .sunFlurries: .sunFlurries,
        .sunShowers: .sunShowers,
        .tropicalStorm: .tropicalStorm,
        .wintryMix: .wintryMix
    ]

    func fetchCurrentWeather(for geoPoint: GeoPoint) async throws -> AppWeather {
        do {
            let location = CLLocation(latitude: geoPoint.lat, longitude: geoPoint.lon)
            let weather = try await service.weather(for: location)

            return AppWeather(
                temperature: weather.currentWeather.temperature.value,
                condition: mapCondition(weather.currentWeather.condition)
            )
        } catch {
            throw WeatherError.serviceUnavailable
        }
    }

    private func mapCondition(_ condition: WeatherKit.WeatherCondition) -> AppWeatherCondition {
        conditionMap[condition] ?? .unknown
    }
}
