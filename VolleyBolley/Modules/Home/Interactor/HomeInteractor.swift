//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import CoreLocation
import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadPlayerData() async throws -> (Player, UIImage?)
    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let playersRepository: PlayersRepositoryProtocol
    private let imageLoader: ImageLoadingServiceProtocol
    private let nearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol

    // MARK: - Initializers

    init(
        playersRepository: PlayersRepositoryProtocol,
        imageLoader: ImageLoadingServiceProtocol,
        nearestCourtWithWeatherUseCase: NearestCourtWithWeatherUseCaseProtocol
    ) {
        self.playersRepository = playersRepository
        self.imageLoader = imageLoader
        self.nearestCourtWithWeatherUseCase = nearestCourtWithWeatherUseCase
    }

    // MARK: - Public Methods

    func loadPlayerData() async throws -> (Player, UIImage?) {
        let player = try await playersRepository.getCurrentPlayer()
        let avatarImage: UIImage?

        if let avatarURL = player.avatarURL {
            avatarImage = try await imageLoader.loadImage(from: avatarURL)
        } else {
            avatarImage = nil
        }

        return (player, avatarImage)
    }

    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather {
        let player = try await playersRepository.getCurrentPlayer()
        let country = player.country.apiValue

        return try await nearestCourtWithWeatherUseCase.getNearestCourtWithWeather(for: country)
    }
}
