//
//  PlayerSession.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

struct PlayerSession: Codable {
    let accessToken: String
    let refreshToken: String
    let playerId: Int
    let isRegistered: Bool
}
