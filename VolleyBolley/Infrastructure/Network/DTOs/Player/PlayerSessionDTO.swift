//
//  PlayerSessionDTO.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

struct PlayerSessionDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let player: CurrentPlayerDTO

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case player
    }
}
