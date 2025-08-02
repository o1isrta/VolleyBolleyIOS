//
//  AppButtonIcon.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// interface buttons
enum AppButtonIcon {
    case backward
    case forward
    case arrowUp
    case arrowDown
    case plus
    case minus
}

// MARK: - AppButtonConfig

extension AppButtonIcon: AppButtonConfig {

    var actionImage: UIImage? { nil }
    var actionTitle: String? { nil }
    var title: String? { nil }

    var image: UIImage? {
        switch self {
        case .backward: return .chevronBackward
        case .forward: return .chevronForward
        case .arrowUp: return .chevronUp
        case .arrowDown: return .chevronDown
        case .plus: return .plus
        case .minus: return .minus
        }
    }

    func style(for state: UIControl.State) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .iconNormal
        case .selected:
            return .iconSelected
        case [.selected, .highlighted]:
            return .iconHighlightedSelected
        case [.normal, .highlighted]:
            return .iconHighlightedNormal
        default:
            return .iconNormal
        }
    }
}
