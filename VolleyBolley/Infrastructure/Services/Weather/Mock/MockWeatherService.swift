//
//  MockWeatherService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

final class MockWeatherService: DefaultWeatherServiceProtocol {

    func fetchCurrentWeather(for geoPoint: GeoPoint) async throws -> AppWeather {

        return AppWeather(
            temperature: 26.0,
            condition: .partlyCloudy
        )
    }
}
