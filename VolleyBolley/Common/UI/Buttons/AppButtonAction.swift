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
    var supportedStates: [AppButtonVisualState] {
        return [.normal, .selected]
    }

    var title: String? {
        switch self {
        case .createTourney: return "Create a Tourney"
        case .invitePlayers:
            return "Invite Players"
        case .sendInvites:
            return "Send Invites"
        case .saveGame:
            return "Save Game"
        case .donate:
            return "Donate"
        case .shareLink:
            return "Share Link"
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

    func style(for state: AppButtonVisualState) -> AppButtonStyle {
        guard supportedStates.contains(state) else {
            assertionFailure("Warning: Unsupported state: \(state)")
            return .actionNormal
        }

        switch state {
        case .normal:
            return .actionNormal
        case .selected:
            return .actionSelected
        default:
            return .actionNormal
        }
    }
}
