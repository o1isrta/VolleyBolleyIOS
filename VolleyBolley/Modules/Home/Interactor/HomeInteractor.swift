//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather
    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let locationRepository: LocationRepositoryProtocol
    private let courtsRepository: CourtsRepositoryProtocol
    private let findNearestCourtUseCase: FindNearestCourtUseCaseProtocol

    // MARK: - Initializers

    init(
        locationRepository: LocationRepositoryProtocol,
        courtsRepository: CourtsRepositoryProtocol,
        findNearestCourtUseCase: FindNearestCourtUseCaseProtocol
    ) {
        self.locationRepository = locationRepository
        self.courtsRepository = courtsRepository
        self.findNearestCourtUseCase = findNearestCourtUseCase
    }

    // MARK: - Public Methods

    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather {
        let playerLocation = try await locationRepository.getPlayerLocation(forceUpdate: false)
        let courts = try await courtsRepository.getCourts(forceRefresh: false)
        // TODO: - remove mock weather
        let weather = AppWeather(temperature: 26.0, condition: .partlyCloudy)

        let nearestCourt = findNearestCourtUseCase.execute(
            userLocation: playerLocation, courts: courts
        )

        let nearestCourtWithWeather = NearestCourtWithWeather(court: nearestCourt, weather: weather)

        return nearestCourtWithWeather
    }

    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int {
        // TODO: - remove mock data
        12
    }
}
