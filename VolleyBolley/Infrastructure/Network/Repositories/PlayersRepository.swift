//
//  PlayersRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

protocol PlayersRepositoryProtocol {
    func getCurrentPlayer() async throws -> Player
}

final class PlayersRepository: PlayersRepositoryProtocol, ServiceInitializable {
    private let service: PlayersServiceProtocol

    // MARK: - Initializers

    init(service: PlayersServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getCurrentPlayer() async throws -> Player {
        let dto = try await service.fetchCurrentPlayer()
        return dto.toDomain()
    }
}
