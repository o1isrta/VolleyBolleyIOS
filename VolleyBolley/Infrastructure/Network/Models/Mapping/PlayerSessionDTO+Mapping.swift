//
//  PlayerSessionDTO+Mapping.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.02.2026.
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
