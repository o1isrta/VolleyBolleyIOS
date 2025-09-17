//
//  TournamentListItemDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

struct TournamentListItemDTO: Decodable {

    let tournamentId: Int
    let host: HostDTO
    let courtLocation: CourtLocationDTO
    let message: String
    let startTime: Date
    let endTime: Date

    enum CodingKeys: String, CodingKey {
        case tournamentId = "tournament_id"
        case host
        case courtLocation = "court_location"
        case message
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
