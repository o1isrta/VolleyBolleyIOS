//
//  AppConstants.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.09.2025.
//

import Foundation

enum AppConstants {

	static let bundleIdentifier = "VB.VolleyBolley"

	enum AppLocale {
		static let posix = Locale(identifier: "en_US_POSIX")
	}

	enum UserDefaultsKeys {
		static let onboardingShown = "onboardingShown"
		static let authorized = "authorized"
		static let currentNotifications = "currentNotifications"
		static let hasNewNotifications = "hasNewNotifications"
	}

	enum Notifications {
		static let checkInterval: TimeInterval = 300
	}

	enum Game {
		static let minimumDurationHours: Double = 1.0
		static let minPlayers = 4
		static let minTeams = 3
		static let maxTeamsAndPlayersValue = 24 
	}

	enum Contacts {
		static let email: String = "volleybolley.app@gmail.com"
		static let linktreeURL: String = "https://linktr.ee/volleybolley.app"
		static let whatsAppURL: String = "https://wa.me/message/LEFHH2AQMSE3D1"
	}
}
