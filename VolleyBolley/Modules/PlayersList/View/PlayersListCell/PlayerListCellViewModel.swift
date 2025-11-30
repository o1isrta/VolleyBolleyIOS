//
//  PlayerListCellViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 30.11.2025.
//

import UIKit

struct PlayerListCellViewModel {
	let avatar: UIImage?
	let name: String
	let isFavorite: Bool
	let level: String
	let onFavoriteToggle: ((Bool) -> Void)?

	init(
		avatar: UIImage?,
		firstName: String,
		lastName: String,
		isFavorite: Bool,
		level: String,
		onFavoriteToggle: ((Bool) -> Void)?
	) {
		self.init(
			avatar: avatar,
			name: "\(firstName) \(lastName)",
			isFavorite: isFavorite,
			level: level,
			onFavoriteToggle: onFavoriteToggle
		)
	}

	init(
		avatar: UIImage?,
		name: String,
		isFavorite: Bool,
		level: String,
		onFavoriteToggle: ((Bool) -> Void)?
	) {
		self.avatar = avatar
		self.name = name
		self.isFavorite = isFavorite
		self.level = String(level.prefix(1).uppercased())
		self.onFavoriteToggle = onFavoriteToggle
	}
}
