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

	enum UserDefaults {

		enum Keys {
			static let onboardingShown = "onboardingShown"
			static let authorized = "authorized"

			static let currentNotifications = "currentNotifications"
			static let hasNewNotifications = "hasNewNotifications"
		}
	}

	enum Notifications {
		static let checkInterval: TimeInterval = 300
	}
}
