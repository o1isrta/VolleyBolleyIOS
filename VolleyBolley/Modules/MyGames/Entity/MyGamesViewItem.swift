//
//  MyGamesViewItem.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import Foundation

struct MyGamesViewItem {
	let type: MyGameMenuItem
	let title: String
	let description: String?
	let badge: String?

	init(
		type: MyGameMenuItem,
		title: String,
		description: String? = nil,
		badge: String? = nil
	) {
		self.type = type
		self.title = title
		self.description = description
		self.badge = badge
	}
}

enum MyGameMenuItem {
	case myGames
	case upcomingGames
	case gameInvites
	case completedGames
}
