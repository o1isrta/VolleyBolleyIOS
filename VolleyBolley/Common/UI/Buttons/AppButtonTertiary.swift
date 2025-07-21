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

    private var style: AppButtonStyle {
        AppButtonStyle(
            backgroundColor: AppColor.Background.buttonMap,
            titleColor: AppColor.Text.inverted,
            font: AppFont.Hero.regular(size: 16),
            cornerRadius: 10
        )
    }
}

// MARK: - AppButtonConfig

extension AppButtonTertiary: AppButtonConfig {

    var supportedStates: [AppButtonVisualState] {
        return [.selected]
    }

    var title: String? {
        return "Map"
    }

    var image: UIImage? {
        nil
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle {
        guard supportedStates.contains(state) else {
             assertionFailure("Warning: State \(state) not supported by \(self)")
             return style
         }

        return style
    }
}
