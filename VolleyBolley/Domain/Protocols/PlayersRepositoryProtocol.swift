//
//  PlayersRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

protocol PlayersRepositoryProtocol {
    func getCurrentPlayer(forceRefresh: Bool) async throws -> Player
}
