//
//  FAQItem.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.10.2025.
//

import Foundation

enum FAQItem: CaseIterable {
	case registration
	case postGameRatings
	case moveToNextCategory
	case levelDrop
	case fairPlayPolicy

	var title: String {
		switch self {
		case .registration:
			return String(localized: "Registration")
		case .postGameRatings:
			return String(localized: "Post-Game Ratings")
		case .moveToNextCategory:
			return String(localized: "Want to move to the next category?")
		case .levelDrop:
			return String(localized: "Levels can drop due to:")
		case .fairPlayPolicy:
			return String(localized: "Fair Play Policy")
		}
	}

	var subtitle: String {
		switch self {
		case .registration:
			return String(localized: """
			To find the right games and teammates, choose your current skill level:
			Options:
			  • Light (L1–L3) – Beginner
			  • Medium (M1–M3) – Confident amateur
			  • Hard (H1–H3) – Advanced
			  • Pro (P1–P3) – Professional
			The higher the number, the higher the skill. Your level may change later based on player ratings.
			""")
		case .postGameRatings:
			return String(localized: """
			After each game, teammates can rate your level.
			Once you receive 6 ratings, your level may change:
			  • 5+ positive ratings → promoted one step
			  • 5+ negative ratings → demoted one step
			  • Mixed feedback → level stays the same
			""")
		case .moveToNextCategory:
			return String(localized: """
			Earn 10 points from higher-level players within the last 60 days.
			The higher the evaluator’s level, the more weight their rating carries.
			""")
		case .levelDrop:
			return String(localized: """
			Ratings (6 within 60 days, 5+ down = demotion)
			Inactivity:
			• 90 days = minus 1 step
			• 180 days = reset to lowest level in current category
			""")
		case .fairPlayPolicy:
			return String(localized: """
			We ensure a fair system:
			• Ratings are anonymous
			• Max 2 ratings from the same player in 60 days
			• Light has minimal impact on Hard and Pro levels
			• Pro levels are harder to reach
			Play fair — your level will speak for itself.
			""")
		}
	}
}
