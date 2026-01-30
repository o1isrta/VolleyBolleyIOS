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
	let index: Int?

	init(
		name: String,
		level: String,
		index: Int?
	) {
		self.name = name
		self.level = level.prefix(1).uppercased()
		self.index = index
	}

	init(
		firstName: String,
		lastName: String,
		level: String,
		index: Int?
	) {
		self.init(
			name: "\(firstName) \(lastName)",
			level: level,
			index: index
		)
	}
}
