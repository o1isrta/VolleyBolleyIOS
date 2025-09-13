//
//  GameDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 11.08.2025.
//

import Foundation

struct GameDTO: Decodable {
    let id: Int
    let description: String
    let venueId: Int // ID площадки, где игра проходит
    let date: String
    let durationMinutes: Int
    let gender: [String]
    let playerLevel: [String]
    let maxPlayers: Int
    let privacy: String
    let pricePerPlayer: Decimal
    let players: [PlayerDTO]
    let status: String // "scheduled", "cancelled", "completed"
}
