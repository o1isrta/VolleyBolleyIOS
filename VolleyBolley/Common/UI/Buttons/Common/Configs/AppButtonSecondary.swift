//
//  AppButtonSecondary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

enum AppButtonSecondary {
    case change
    case dateToday
    case dateTomorrow
    case datePickDate
    case genderMix
    case genderMen
    case genderWomen
    case levelLight
    case levelMedium
    case levelHard
    case levelPro
    case privacyPublic
    case privacyPrivate
    case tourneyIndividual
    case tourneyTeam
    case managePlayers
    case addPayment
}

// MARK: - AppButtonConfig

extension AppButtonSecondary: AppButtonConfig {
    
    var actionImage: UIImage? { nil }
    var actionTitle: String? { nil }
    var image: UIImage? { nil }

    var title: String? {
        switch self {
        case .change: return String(localized: "common.change")
        case .dateToday: return String(localized: "common.today")
        case .dateTomorrow: return String(localized: "common.tomorrow")
        case .datePickDate: return String(localized: "common.pickDate")
        case .genderMix: return String(localized: "common.mix")
        case .genderMen: return String(localized: "common.men")
        case .genderWomen: return String(localized: "common.women")
        case .levelLight: return String(localized: "common.light")
        case .levelMedium: return String(localized: "common.medium")
        case .levelHard: return String(localized: "common.hard")
        case .levelPro: return String(localized: "common.pro")
        case .privacyPublic: return String(localized: "common.public")
        case .privacyPrivate: return String(localized: "common.private")
        case .tourneyIndividual: return String(localized: "common.individual")
        case .tourneyTeam: return String(localized: "common.team")
        case .managePlayers: return String(localized: "common.managePlayers")
        case .addPayment: return String(localized: "common.addPayment")
        }
    }

    func style(for state: UIControl.State) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .secondaryNormal
        case .selected:
            return .secondarySelected
        case [.selected, .highlighted]:
            return .secondaryHighlightedSelected
        case [.normal, .highlighted]:
            return .secondaryHighlightedNormal
        default:
            return .secondaryNormal
        }
    }
}
