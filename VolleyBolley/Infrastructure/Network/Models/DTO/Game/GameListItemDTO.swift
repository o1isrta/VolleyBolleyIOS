//
//  GameListItemDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 15.09.2025.
//

import Foundation

struct GameListItemDTO: Decodable {

    let gameId: Int
    let host: HostDTO
    let courtLocation: CourtLocationDTO
    let message: String
    let startTime: Date
    let endTime: Date

    enum CodingKeys: String, CodingKey {
        case gameId = "game_id"
        case host
        case courtLocation = "court_location"
        case message
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
