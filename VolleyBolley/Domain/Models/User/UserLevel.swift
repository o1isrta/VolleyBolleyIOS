//
//  UserLevel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import UIKit

// TODO(API): Temporary implementation — waiting for backend spec
enum UserLevel: CaseIterable {
    case light
    case medium
    case hard
    case pro
    case unknown

    init(rawValue: Int) {
        switch rawValue {
        case 0...4: self = .light
        case 5...9: self = .medium
        case 10...14: self = .hard
        case 15...20: self = .pro
        default: self = .unknown
        }
    }

    var title: String {
        switch self {
        case .light: return String(localized: "common.light").uppercased()
        case .medium: return String(localized: "common.medium").uppercased()
        case .hard: return String(localized: "common.hard").uppercased()
        case .pro: return String(localized: "common.pro").uppercased()
        case .unknown: return "-"
        }
    }

    var color: UIColor {
        switch self {
        case .light: return AppColor.Background.levelBadgeLight
        case .medium: return AppColor.Background.levelBadgeMedium
        case .hard: return AppColor.Background.levelBadgeHard
        case .pro: return AppColor.Background.levelBadgePro
        case .unknown: return .gray
        }
    }

    var titleColor: UIColor {
        switch self {
        case .light, .medium, .unknown:
            return AppColor.Text.primary
        case .hard, .pro:
            return AppColor.Text.inverted
        }
    }
}
