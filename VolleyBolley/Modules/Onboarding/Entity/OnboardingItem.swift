//
//  OnboardingItem.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 15.07.2025.
//

import UIKit

enum OnboardingItem: Int, CaseIterable {
    case welcome

    var title: String {
        switch self {
        case .welcome: return String(localized: "Welcome!", comment: "Onboarding item title")
        }
    }

    var message: String {
        switch self {
        case .welcome: return String(
            localized: "This app helps you find beach volleyball games and match with players at your skill level.!",
            comment: "Onboarding item message"
        )
        }
    }
}
