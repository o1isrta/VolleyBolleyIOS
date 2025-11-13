//
//  UserCardViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import Foundation

struct UserCardViewModel {
	let name: String
	let level: PlayerLevel

	init(
		firstName: String,
		lastName: String,
		level: PlayerLevel
	) {
		self.name = "\(firstName) \(lastName)"
		self.level = level
	}
}
