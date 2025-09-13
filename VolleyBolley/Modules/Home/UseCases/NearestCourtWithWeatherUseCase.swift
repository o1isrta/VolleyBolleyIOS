//
//  NearestCourtWithWeatherUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.09.2025.
//

import Foundation

protocol NearestCourtWithWeatherUseCaseProtocol {
    func getNearestCourtWithWeather(for country: String) async throws -> NearestCourtWithWeather
}

final class NearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol {

    // MARK: - Private Properties

    private let locationRepository: LocationRepositoryProtocol
    private let courtRepository: CourtsRepositoryProtocol
    private let weatherRepository: WeatherRepositoryProtocol

    // MARK: - Initializers

    init(
        locationRepository: LocationRepositoryProtocol,
        courtRepository: CourtsRepositoryProtocol,
        weatherRepository: WeatherRepositoryProtocol,
    ) {
        self.locationRepository = locationRepository
        self.courtRepository = courtRepository
        self.weatherRepository = weatherRepository
    }

    // MARK: - Public Methods

    func getNearestCourtWithWeather(for country: String) async throws -> NearestCourtWithWeather {
        let userLocation = try await locationRepository.getPlayerLocation()
        let nearestCourt = try await courtRepository.getNearestCourt(for: country, userLocation: userLocation)

        do {
            let weather = try await weatherRepository.getCurrentWeather(for: nearestCourt.location)
            return NearestCourtWithWeather(court: nearestCourt, weather: weather)
        } catch {
            print("Weather fetch failed: \(error.localizedDescription)")
            return NearestCourtWithWeather(court: nearestCourt, weather: nil)
        }
    }
}
