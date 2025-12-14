//
//  UserInfoModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 30.11.2025.
//

import Foundation

struct UserInfoModel: Codable, Equatable {
	let playerId: Int
	let firstName: String
	let lastName: String
	let avatar: String?
	let isFavorite: Bool
	let level: String

	private enum CodingKeys: String, CodingKey {
		case playerId = "player_id"
		case firstName = "first_name"
		case lastName = "last_name"
		case avatar
		case isFavorite = "is_favorite"
		case level
	}
}

extension UserInfoModel {
	func copy(
		playerId: Int? = nil,
		firstName: String? = nil,
		lastName: String? = nil,
		avatar: String?? = nil,
		isFavorite: Bool? = nil,
		level: String? = nil
	) -> UserInfoModel {
		.init(
			playerId: playerId ?? self.playerId,
			firstName: firstName ?? self.firstName,
			lastName: lastName ?? self.lastName,
			avatar: avatar ?? self.avatar,
			isFavorite: isFavorite ?? self.isFavorite,
			level: level ?? self.level
		)
	}
}
