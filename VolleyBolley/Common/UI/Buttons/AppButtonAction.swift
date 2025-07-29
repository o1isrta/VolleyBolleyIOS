//
//  AppButtonActionPrimary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// желтый фон черный текст белая иконка для selected
/// прозрачный фон для unselected
enum AppButtonAction {
    case createTourney
    case invitePlayers
    case sendInvites
    case saveGame
    case donate
    case shareLink
}

// MARK: - AppButtonConfig

extension AppButtonAction: AppButtonConfig {
    var defaultStyle: AppButtonStyle {
        .actionNormal
    }

    var supportedStates: [AppButtonVisualState] {
        return [.normal, .selected]
    }

    var title: String? {
        switch self {
        case .createTourney: return String(localized: "common.createTourney")
        case .invitePlayers: return String(localized: "common.invitePlayers")
        case .sendInvites: return String(localized: "common.sendInvites")
        case .saveGame: return String(localized: "common.saveGame")
        case .donate: return String(localized: "common.donate")
        case .shareLink: return String(localized: "common.shareLink")
        }
    }

    var image: UIImage? {
        switch self {
        case .createTourney: return UIImage.Icon.createTourney
        case .invitePlayers: return UIImage.Icon.invitePlayers
        case .sendInvites: return UIImage.Icon.sendInvites
        case .saveGame: return UIImage.Icon.saveGame
        case .donate: return UIImage.Icon.donate
        case .shareLink: return UIImage.Icon.share
        }
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .actionNormal
        case .selected:
            return .actionSelected
        default:
            return nil
        }
    }
}
