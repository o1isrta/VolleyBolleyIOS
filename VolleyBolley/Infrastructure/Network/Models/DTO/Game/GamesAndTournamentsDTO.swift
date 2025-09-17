//
//  GamesAndTournamentsDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

struct GamesAndTournamentsDTO: Decodable {
    let games: [GameListItemDTO]
    let tournaments: [TournamentListItemDTO]
}
