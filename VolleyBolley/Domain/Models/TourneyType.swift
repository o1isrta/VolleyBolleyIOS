//
//  TourneyType.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 18.10.2025.
//

import Foundation

enum TourneyType {
	case individual
	case team
}

extension TourneyType {
	var counterType: CounterType {
		switch self {
		case .individual:
			return .players
		case .team:
			return .teams
		}
	}
}
