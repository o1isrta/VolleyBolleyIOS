//
//  GameType.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 19.10.2025.
//

import Foundation

enum GameType {
	case game
	case tourney

	var title: String {
		switch self {
		case .game:
			return String(localized: "newGameOrTourney.title.game")
		case .tourney:
			return String(localized: "newGameOrTourney.title.tourney")
		}
	}

	var cells: [GameCellType] {
		switch self {
		case .game:
			return [
				.message,
				.location,
				.date,
				.gender,
				.playerLevels
			]
		case .tourney:
			return [
				.message,
				.location,
				.date,
				.tourneyType,
				.gender,
				.playerLevels
			]
		}
	}
}

enum GameCellType: CaseIterable {
	case message
	case location
	case date
	case tourneyType
	case gender
	case playerLevels
}
