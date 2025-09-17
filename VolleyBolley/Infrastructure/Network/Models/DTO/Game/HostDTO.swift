//
//  HostDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.09.2025.
//

import Foundation

struct HostDTO: Decodable {
    let playerId: Int
    let firstName: String
    let lastName: String
    let avatar: String?
    let level: String

    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case level
    }
}
