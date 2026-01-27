//
//  PlayerElementListViewCellModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.01.2026.
//

import Foundation

struct PlayerElementListViewCellModel {
	let name: String
	let level: String

	init(name: String, level: String) {
		self.name = name
		self.level = level.prefix(1).uppercased()
	}

	init(
		firstName: String,
		lastName: String,
		level: String
	) {
		self.name = "\(firstName) \(lastName)"
		self.level = level.prefix(1).uppercased()
	}
}
