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
		static let onboardingShown = "onboardingShown"
	}

	enum Notifications {
		static let checkInterval: TimeInterval = 300
	}

	enum Contacts {
		static let email: String = "volleybolley.app@gmail.com"
		static let linktreeURL: String = "https://linktr.ee/volleybolley.app"
		static let whatsAppURL: String = "https://wa.me/message/LEFHH2AQMSE3D1"
	}
}
