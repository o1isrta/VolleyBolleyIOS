//
//  AppButtonSecondary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// градиентный фон selected
/// градиентный бордер для unselected
enum AppButtonSecondary {
    case change
    case selectLevel
    case setLevel
    case selectGender
    case selectPrivacy
    case managePlayers
    case selectDate
}

// MARK: - AppButtonConfig

extension AppButtonSecondary: AppButtonConfig {

    var supportedStates: [AppButtonVisualState] {
        return [.normal, .selected]
    }

    var title: String? {
        switch self {
        case .change: return "Change"
        case .selectLevel: return "Select Level"
        case .setLevel: return "Set Level"
        case .selectGender: return "Select Gender"
        case .selectPrivacy: return "Select Privacy"
        case .managePlayers: return "Manage Players"
        case .selectDate: return "Select Date"
        }
    }

    var image: UIImage? {
        nil
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle {
        guard supportedStates.contains(state) else {
            assertionFailure("Warning: Unsupported state: \(state)")
            return .secondaryNormal
        }

        switch state {
        case .normal:
            return .secondaryNormal
        case .selected:
            return .secondarySelected
        default:
            return .secondaryNormal
        }
    }
}
