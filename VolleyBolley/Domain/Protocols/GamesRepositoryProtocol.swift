//
//  GamesRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

protocol GamesRepositoryProtocol {
    func getUpcomingGames(forceRefresh: Bool) async throws -> (
        games: [GameListItem],
        tournaments: [TournamentListItem]
    )
}
