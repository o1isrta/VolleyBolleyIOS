//
//  SupportItem.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.10.2025.
//

import Foundation

enum SupportItem: CaseIterable {
	case faq
	case linktree
	case contactUs
	case whatsApp

	var title: String {
		switch self {
		case .faq: return String(localized: "support.faq")
		case .linktree: return String(localized: "support.linktree")
		case .contactUs: return String(localized: "support.contactUs")
		case .whatsApp: return String(localized: "support.whatsApp")
		}
	}

	var description: String {
		switch self {
		case .faq: return String(localized: "support.faq.description")
		case .linktree: return String(localized: "support.linktree.description")
		case .contactUs: return AppConstants.Contacts.email
		case .whatsApp: return String(localized: "support.whatsApp.description")
		}
	}
}
