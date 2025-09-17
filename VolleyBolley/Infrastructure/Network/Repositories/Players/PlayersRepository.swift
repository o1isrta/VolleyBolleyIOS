//
//  PlayersRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

final class PlayersRepository: PlayersRepositoryProtocol, ServiceInitializable {

    // MARK: - Private Properties

    private let service: PlayersServiceProtocol
    private var cachedPlayer: Player?

    // MARK: - Initializers

    init(service: PlayersServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getCurrentPlayer(forceRefresh: Bool = false) async throws -> Player {
        if let cachedPlayer, !forceRefresh {
            return cachedPlayer
        }

        do {
            let dto = try await service.fetchCurrentPlayer()
            let player = dto.toDomain()
            cachedPlayer = player
            return player
        } catch let error as NetworkError {
            throw PlayersError.from(error)
        } catch {
            throw PlayersError.unknown
        }
    }
}

//    func getCurrentPlayer(forceRefresh: Bool = false) async throws -> Player {
//        if let cachedPlayer, !forceRefresh {
//            return cachedPlayer
//        }
//
//        let dto = try await service.fetchCurrentPlayer()
//        let player = dto.toDomain()
//        cachedPlayer = player
//
//        return player
//    }
