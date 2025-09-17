//
//  GamesRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 14.09.2025.
//

final class GamesRepository: GamesRepositoryProtocol, ServiceInitializable {

    // MARK: - Private Properties

    private let service: GamesServiceProtocol
    private var cachedUpcoming: (games: [GameListItem], tournaments: [TournamentListItem])?

    // MARK: - Initializers

    init(service: GamesServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

    func getUpcomingGames(forceRefresh: Bool = false) async throws -> (
        games: [GameListItem],
        tournaments: [TournamentListItem]
    ) {
        if let cached = cachedUpcoming, !forceRefresh {
            return cached
        }

        do {
            let dto = try await service.fetchUpcomingGamesAndTournaments()
            let games = dto.games.map { $0.toDomain() }
            let tournaments = dto.tournaments.map { $0.toDomain() }

            cachedUpcoming = (games, tournaments)

            return (games, tournaments)
        } catch let error as NetworkError {
            throw GamesError.from(error)
        } catch {
            throw GamesError.unknown
        }
    }
}
