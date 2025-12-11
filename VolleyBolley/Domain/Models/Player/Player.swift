//
//  Player.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 16.07.2025.
//

import Foundation

struct Player {
	let firstName: String
	let lastName: String
	let gender: String
	let dateOfBirth: Date?
	let level: PlayerLevel
	let countryID: Int
	let cityID: Int
	let avatarURL: URL?
}

extension Player {

	static var mockDefault = Player(
		firstName: "Artem",
		lastName: "Ivanov",
		gender: "Male",
		dateOfBirth: Date(),
		level: PlayerLevel.light,
		countryID: 0,
		cityID: 0,
		avatarURL: nil
	)
}
