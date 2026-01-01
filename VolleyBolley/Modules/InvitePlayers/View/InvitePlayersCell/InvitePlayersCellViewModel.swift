//
//  InvitePlayersCellViewModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Foundation

struct InvitePlayersCellViewModel {
	let name: String
	let level: String
	let isFavorite: Bool
	let isSelected: Bool
	let onFavoriteToggle: ((Bool) -> Void)?
	let onCheckmarkToggle: ((Bool) -> Void)?

	init(
		firstName: String,
		lastName: String,
		level: String,
		isFavorite: Bool,
		isSelected: Bool,
		onFavoriteToggle: ((Bool) -> Void)?,
		onCheckmarkToggle: ((Bool) -> Void)?
	) {
		self.init(
			name: "\(firstName) \(lastName)",
			level: level,
			isFavorite: isFavorite,
			isSelected: isSelected,
			onFavoriteToggle: onFavoriteToggle,
			onCheckmarkToggle: onCheckmarkToggle
		)
	}

	init(
		name: String,
		level: String,
		isFavorite: Bool,
		isSelected: Bool,
		onFavoriteToggle: ((Bool) -> Void)?,
		onCheckmarkToggle: ((Bool) -> Void)?
	) {
		self.name = name
		self.level = String(level.prefix(1).uppercased())
		self.isFavorite = isFavorite
		self.isSelected = isSelected
		self.onFavoriteToggle = onFavoriteToggle
		self.onCheckmarkToggle = onCheckmarkToggle
	}
}
