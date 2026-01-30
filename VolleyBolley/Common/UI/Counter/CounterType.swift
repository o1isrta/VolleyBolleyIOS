//
//  CounterType.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 30.01.2026.
//

import Foundation

enum CounterType {
	case players
	case teams

	var title: String {
		switch self {
		case .players: return String(localized: "counter.playersTitle")
		case .teams: return String(localized: "counter.teamsTitle")
		}
	}

	var minValue: Int {
		switch self {
		case .players: return LimitConstants.minPlayers
		case .teams: return LimitConstants.minTeams
		}
	}

	var maxValue: Int { LimitConstants.maxValue }

	private enum LimitConstants {
		static let minPlayers = AppConstants.Game.minPlayers
		static let minTeams = AppConstants.Game.minTeams
		static let maxValue = AppConstants.Game.maxTeamsAndPlayersValue
	}
}
