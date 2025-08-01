//
//  AppButtonTertiary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// оранжевый фон и черный текст/
enum AppButtonTertiary {
    case map
}

// MARK: - AppButtonConfig

extension AppButtonTertiary: AppButtonConfig {

    var actionImage: UIImage? { nil }
    var actionTitle: String? { nil }
    var image: UIImage? { nil }

    var title: String? {
        return String(localized: "common.map")
    }

    func style(for state: UIControl.State) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .tertiaryNormal
        case .highlighted:
            return .tertiaryHighlighted
        default:
            return .tertiaryNormal
        }
    }
}
