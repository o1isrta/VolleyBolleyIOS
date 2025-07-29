//
//  AppButtonIcon.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// interface buttons
enum AppButtonIcon {
    case back
    case plus
    case minus
}

// MARK: - AppButtonConfig

extension AppButtonIcon: AppButtonConfig {
    var supportedStates: [AppButtonVisualState] {
        [.normal, .selected]
    }

    var defaultStyle: AppButtonStyle {
        .iconNormal
    }

    var title: String? {
        nil
    }

    var image: UIImage? {
        switch self {
        case .back: return .chevronBackward
        case .plus: return .plus
        case .minus: return .minus
        }
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle? {
        switch state {
        case .normal: return .iconNormal
        case .selected: return .iconSelected
        default: return nil
        }
    }
}
