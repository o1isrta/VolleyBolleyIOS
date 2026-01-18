//
//  RegistrationLocationType.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 18.01.2026.
//

import Foundation

enum RegistrationLocationType {
	case country
	case city

	var title: String {
		switch self {
		case .country: return String(localized: "Your country")
		case .city: return String(localized: "Your city")
		}
	}

	var placeholder: String {
		switch self {
		case .country: return String(localized: "Choose your country")
		case .city: return String(localized: "Choose your city")
		}
	}

	var isHasSeparator: Bool {
		switch self {
		case .country: return false
		case .city: return true
		}
	}
}
