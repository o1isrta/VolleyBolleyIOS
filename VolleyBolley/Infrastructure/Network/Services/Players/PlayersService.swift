//
//  PlayersService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation
import Moya

protocol PlayersServiceProtocol {
    func fetchCurrentPlayer() async throws -> PlayerDTO
}

final class PlayersService: PlayersServiceProtocol, ProviderInitializable {

    // MARK: - Private Properties
    private let provider: MoyaProvider<PlayersAPI>

    // MARK: - Initializers
    init(provider: MoyaProvider<PlayersAPI>) {
        self.provider = provider
    }

    // MARK: - Public Methods
    func fetchCurrentPlayer() async throws -> PlayerDTO {
        do {
            return try await provider.asyncRequest(
                .getCurrentPlayer,
                type: PlayerDTO.self,
                decoder: AppJSONDecoders.server
            )
        } catch let error as MoyaError {
            throw error.toNetworkError()
        }
    }
}
