//
//  PlayerDTO.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

struct PlayerDTO: Codable {
	let playerId: Int
	let isRegistered: Bool
	let avatar: String?
	let firstName: String?
	let lastName: String?
	let gender: String?
	let birthDate: String?
	let level: String?
	let country: String?
	let city: String?

	private enum CodingKeys: String, CodingKey {
		case playerId = "player_id"
		case isRegistered = "is_registered"
		case avatar
		case firstName = "first_name"
		case lastName = "last_name"
		case gender
		case birthDate = "date_of_birth"
		case level
		case country
		case city
	}

	init(
		playerId: Int,
		avatar: String?,
		firstName: String?,
		lastName: String?,
		gender: String?,
		birthDate: String?,
		level: String?,
		country: String?,
		city: String?
	) {
		self.playerId = playerId
		self.isRegistered = true
		self.avatar = avatar
		self.firstName = firstName
		self.lastName = lastName
		self.gender = gender
		self.birthDate = birthDate
		self.level = level
		self.country = country
		self.city = city
	}
}
