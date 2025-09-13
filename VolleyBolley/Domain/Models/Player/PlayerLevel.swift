//
//  PlayerLevel.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 17.07.2025.
//

import UIKit

struct LevelConfig {
    let titleKey: String
    let backgroundColor: UIColor
    let textColor: UIColor
}

enum PlayerLevel: String, CaseIterable, Decodable {
    case light
    case medium
    case hard
    case pro
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try? container.decode(String.self)
        self = PlayerLevel(rawValue: rawValue?.lowercased() ?? "") ?? .unknown
    }

    private var config: LevelConfig {
        switch self {
        case .light:
            return LevelConfig(
                titleKey: "common.light",
                backgroundColor: AppColor.Background.levelBadgeLight,
                textColor: AppColor.Text.primary
            )
        case .medium:
            return LevelConfig(
                titleKey: "common.medium",
                backgroundColor: AppColor.Background.levelBadgeMedium,
                textColor: AppColor.Text.primary
            )
        case .hard:
            return LevelConfig(
                titleKey: "common.hard",
                backgroundColor: AppColor.Background.levelBadgeHard,
                textColor: AppColor.Text.inverted
            )
        case .pro:
            return LevelConfig(
                titleKey: "common.pro",
                backgroundColor: AppColor.Background.levelBadgePro,
                textColor: AppColor.Text.inverted
            )
        case .unknown:
            return LevelConfig(
                titleKey: "-",
                backgroundColor: .gray,
                textColor: AppColor.Text.primary
            )
        }
    }

    var title: String {
        self == .unknown ? "-" : NSLocalizedString(config.titleKey, comment: "").uppercased()
    }

    var color: UIColor { config.backgroundColor }
    var titleColor: UIColor { config.textColor }
}
