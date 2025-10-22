//
//  GameTimeValidator.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 22.10.2025.
//

import Foundation

enum GameValidationError: Error, LocalizedError {
	case endBeforeStart
	case startInPast
	case durationTooShort(minimumHours: Double)

	var errorDescription: String? {
		switch self {
		case .endBeforeStart:
			return String(localized: "The end of the game cannot be before the beginning")
		case .startInPast:
			return String(localized: "The beginning of the game cannot be in the past")
		case .durationTooShort(let hours):
			return String(localized: "The game duration must be at least \(Int(hours)) hour")
		}
	}
}

struct GameTimeValidator {
	let startDate: Date
	let endDate: Date
	let minimumDuration: TimeInterval

	init(startDate: Date, endDate: Date) {
		self.startDate = startDate
		self.endDate = endDate
		self.minimumDuration = AppConstants.Game.minimumDurationHours * 3600
	}

	func validate() throws {
		guard endDate > startDate else {
			throw GameValidationError.endBeforeStart
		}

		guard startDate >= Date() else {
			throw GameValidationError.startInPast
		}

		let duration = endDate.timeIntervalSince(startDate)
		guard duration >= minimumDuration else {
			throw GameValidationError.durationTooShort(minimumHours: minimumDuration / 3600)
		}
	}
}

extension GameTimeValidator {

	static func validate(start: Date, end: Date) throws {
		try Self(startDate: start, endDate: end)
			.validate()
	}

	static func quickCheck(start: Date, end: Date) -> Bool {
		(try? validate(start: start, end: end)) != nil
	}
}
