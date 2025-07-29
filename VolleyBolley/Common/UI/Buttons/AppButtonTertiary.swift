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
    var defaultStyle: AppButtonStyle {
        .tertiaryNormal
    }

    var supportedStates: [AppButtonVisualState] {
        return [.selected]
    }

    var title: String? {
        return String(localized: "common.map")
    }

    var image: UIImage? {
        nil
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .tertiaryNormal
        default:
            return nil
        }
    }
}
