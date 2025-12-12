//
//  PlayerSessionDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

extension PlayerSessionDTO {

    func toDomain() -> PlayerSession {
        return PlayerSession(
            accessToken: accessToken,
            refreshToken: refreshToken,
            playerId: player.playerId,
            isRegistered: player.isRegistered
        )
    }
}
