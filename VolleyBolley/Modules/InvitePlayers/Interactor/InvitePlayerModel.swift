//
//  InvitePlayerModel.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 02.01.2026.
//

import Foundation

struct InvitePlayerModel: Equatable, Hashable {
	let id: Int
	let name: String
	let isFavorite: Bool
	let isPinned: Bool
	let isSelected: Bool
	let level: String
}

extension InvitePlayerModel {
	func copy(
		id: Int? = nil,
		name: String? = nil,
		isFavorite: Bool? = nil,
		isPinned: Bool? = nil,
		isSelected: Bool? = nil,
		level: String? = nil
	) -> InvitePlayerModel {
		.init(
			id: id ?? self.id,
			name: name ?? self.name,
			isFavorite: isFavorite ?? self.isFavorite,
			isPinned: isPinned ?? self.isPinned,
			isSelected: isSelected ?? self.isSelected,
			level: level ?? self.level
		)
	}
}
