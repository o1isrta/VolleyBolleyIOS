//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadPlayerData() async throws -> (Player, UIImage?)
    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather
    func loadTotalCountOfUpcomingGamesAndTournaments() async throws -> Int
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let playersRepository: PlayersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol
    private let locationRepository: LocationRepositoryProtocol
    private let weatherRepository: WeatherRepositoryProtocol

    private let courtsUseCase: CourtsUseCaseProtocol
    private let gamesUseCase: GamesUseCaseProtocol

    // MARK: - Initializers

    init(
        playersRepository: PlayersRepositoryProtocol,
        imageLoader: ImageLoadingServiceProtocol,
        locationRepository: LocationRepositoryProtocol,
        weatherRepository: WeatherRepositoryProtocol,
        courtsUseCase: CourtsUseCaseProtocol,
        gamesUseCase: GamesUseCaseProtocol
    ) {
        self.playersRepository = playersRepository
        self.imageLoader = imageLoader
        self.locationRepository = locationRepository
        self.weatherRepository = weatherRepository
        self.courtsUseCase = courtsUseCase
        self.gamesUseCase = gamesUseCase
    }

    // MARK: - Public Methods

    func loadPlayerData() async throws -> (Player, UIImage?) {
        let player = try await playersRepository.getCurrentPlayer(forceRefresh: false)
        let avatarImage: UIImage?

        if let avatarURL = player.avatarURL {
            avatarImage = try await imageLoader.loadImage(from: avatarURL)
        } else {
            avatarImage = nil
        }

        return (player, avatarImage)
    }

    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather {
        let playerLocation = try await locationRepository.getPlayerLocation(forceUpdate: false)
        let nearestCourt = try await courtsUseCase.getNearestCourt(
            playerLocation: playerLocation
        )

        let weather = try await weatherRepository.getCurrentWeather(for: nearestCourt.location.point)

        let nearestCourtWithWeather = NearestCourtWithWeather(court: nearestCourt, weather: weather)

        return nearestCourtWithWeather
    }

    func loadTotalCountOfUpcomingGamesAndTournaments() async throws -> Int {
        try await gamesUseCase.getTotalCountOfUpcomingGamesAndTournaments()
    }
}
