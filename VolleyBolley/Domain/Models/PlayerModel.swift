//
//  PlayerModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 03.08.2025.
//

import Foundation

struct PlayerModel: Codable {
	let playerId: Int
	let firstName: String
	let lastName: String
	let level: String

	private enum CodingKeys: String, CodingKey {
		case playerId = "player_id"
		case firstName = "first_name"
		case lastName = "last_name"
		case level
	}
}
