//
//  MockWeatherService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 05.08.2025.
//

//import Foundation
//import CoreLocation
//import WeatherKit
//
//final class MockWeatherService: WeatherServiceProtocol {
    

//    func getCurrentWeather(for location: CLLocation) async throws -> CurrentWeather {
//        return CurrentWeather(
//            temperature: Measurement(value: 22.0, unit: .celsius),
//            apparentTemperature: Measurement(value: 24.0, unit: .celsius),
//            humidity: 0.55,
//            pressure: Measurement(value: 1013.25, unit: .hectopascals),
//            wind: Wind(speed: Measurement(value: 5.0, unit: .metersPerSecond), direction: .north),
//            uvIndex: 5,
//            condition: .partlyCloudy,
//            symbolName: "cloud.sun",
//            precipitation: Precipitation(amount: Measurement(value: 0.0, unit: .millimeters), chance: 0.0, intensity: .none),
//            cloudCover: 0.3,
//            visibility: Measurement(value: 10.0, unit: .kilometers),
//            sunrise: Date(),
//            sunset: Date().addingTimeInterval(60 * 60 * 12), // +12 часов
//            isDaylight: true,
//            forecastStart: Date(),
//            forecastEnd: Date().addingTimeInterval(60 * 60),
//            conditionDescription: "Partly Cloudy"
//        )
//    }
//}
