//
//  WeatherRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.09.2025.
//

protocol WeatherRepositoryProtocol {
    func getCurrentWeather(for geoPoint: GeoPoint) async throws -> AppWeather
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let service: DefaultWeatherServiceProtocol

    init(service: DefaultWeatherServiceProtocol) {
        self.service = service
    }

    func getCurrentWeather(for geoPoint: GeoPoint) async throws -> AppWeather {
        do {
            return try await service.fetchCurrentWeather(for: geoPoint)
        } catch let error as WeatherError {
            throw error
        } catch {
            throw WeatherError.unknown(error)
        }
    }
}
