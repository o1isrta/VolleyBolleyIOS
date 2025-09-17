//
//  GamesService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 14.09.2025.
//

import Foundation
import Moya

protocol GamesServiceProtocol {
    func fetchUpcomingGamesAndTournaments() async throws -> GamesAndTournamentsDTO
}

final class GamesService: GamesServiceProtocol, ProviderInitializable {

    // MARK: - Private Properties

    private let provider: MoyaProvider<GamesAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<GamesAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods

    func fetchUpcomingGamesAndTournaments() async throws -> GamesAndTournamentsDTO {
        do {
            return try await provider.asyncRequest(
                .getUpcomingGames,
                type: GamesAndTournamentsDTO.self,
                decoder: AppJSONDecoders.server
            )
        } catch let error as MoyaError {
            throw error.toNetworkError()
        }
    }
}
