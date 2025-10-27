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
	case durationTooLong(maximumHours: Double)

	var errorDescription: String? {
		switch self {
		case .endBeforeStart:
			return String(localized: "The end of the game cannot be before the beginning")
		case .startInPast:
			return String(localized: "The beginning of the game cannot be in the past")
		case .durationTooShort(let hours):
			let hourCount = Int(hours)
			return String(localized: "The game duration must be at least \(hourCount) hour")
		case .durationTooLong(let hours):
			let hourCount = Int(hours)
			return String(localized: "The game duration cannot exceed \(hourCount) hour")
		}
	}
}

struct GameTimeValidator {
	let startDate: Date
	let endDate: Date
	let minimumDuration: TimeInterval
	let maximumDuration: TimeInterval?

	init(gameType: GameType, startDate: Date, endDate: Date) {
		self.startDate = startDate
		self.endDate = endDate
		self.minimumDuration = AppConstants.Game.minimumDurationHours * .hour
		self.maximumDuration = gameType == .game ? AppConstants.Game.maximumDurationHours * .hour : nil
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
			throw GameValidationError.durationTooShort(minimumHours: minimumDuration / .hour)
		}

		if let maxDuration = maximumDuration,
			duration > maxDuration {
			throw GameValidationError.durationTooLong(maximumHours: maxDuration / .hour)
		}
	}
}

extension GameTimeValidator {

	static func validate(gameType: GameType, start: Date, end: Date) throws {
		try Self(gameType: gameType, startDate: start, endDate: end)
			.validate()
	}

	static func quickCheck(gameType: GameType, start: Date, end: Date) -> Bool {
		(try? validate(gameType: gameType, start: start, end: end)) != nil
	}
}
