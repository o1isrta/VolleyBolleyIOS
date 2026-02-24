//
//  PlayerSession.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct PlayerSession: Decodable {
	let accessToken: String
	let refreshToken: String
	let playerId: Int
	let isRegistered: Bool
}
