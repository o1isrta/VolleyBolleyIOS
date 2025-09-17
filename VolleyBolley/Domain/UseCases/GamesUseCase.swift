//
//  GamesUseCase.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 13.09.2025.
//

import Foundation

protocol GamesUseCaseProtocol {
    func getUpcomingGamesSorted(by userLocation: GeoPoint) async throws -> [GameListItem]
    func getUpcomingTournamentsSorted(by userLocation: GeoPoint) async throws -> [TournamentListItem]
    func getTotalCountOfUpcomingGamesAndTournaments() async throws -> Int
}

final class GamesUseCase: GamesUseCaseProtocol {

    // MARK: - Private Properties

    private let gamesRepository: GamesRepositoryProtocol

    // MARK: - Initializers

    init(gamesRepository: GamesRepositoryProtocol) {
        self.gamesRepository = gamesRepository
    }

    func getUpcomingGamesSorted(by userLocation: GeoPoint) async throws -> [GameListItem] {
        let result = try await gamesRepository.getUpcomingGames(forceRefresh: false)
        return result.games.sorted { $0.location.point.distanceInKilometers(to: userLocation) <
                                    $1.location.point.distanceInKilometers(to: userLocation) }
    }

    func getUpcomingTournamentsSorted(by userLocation: GeoPoint) async throws -> [TournamentListItem] {
        let result = try await gamesRepository.getUpcomingGames(forceRefresh: false)
        return result.tournaments.sorted { $0.location.point.distanceInKilometers(to: userLocation) <
                                          $1.location.point.distanceInKilometers(to: userLocation) }
    }

    func getTotalCountOfUpcomingGamesAndTournaments() async throws -> Int {
        let result = try await gamesRepository.getUpcomingGames(forceRefresh: false)
        return result.games.count + result.tournaments.count
    }
}
