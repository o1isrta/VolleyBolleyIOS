//
//  AppButtonPrimary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

/// желтый фон черный текст для selected
/// желтый бордер белый текст unseleted
/// серый фон белый текст для неактивного состояния
enum AppButtonPrimary {
    case nextStep
    case save
    case saveGame
    case createGame
    case addSelected
    case done
    case chooseCourt
    case chooseTourney
    case chooseTeam
    case joinTourney
    case joinGame
    case invitePlayers
    case addPayment
    case addFavorite
    case ratePlayers
    case getStarted
    case sendCode
    case verify
    case ok
    case yes
    case retry
    case update
    case decline
    case details
    case skip
    case unfavorite
    case no
}

// MARK: - AppButtonConfig

extension AppButtonPrimary: AppButtonConfig {
    var defaultStyle: AppButtonStyle {
        .primaryNormal
    }

    var supportedStates: [AppButtonVisualState] {
        return [.normal, .selected, .disabled]
    }

    var title: String? {
        switch self {
        case .save: return "Save"
        case .nextStep: return "Next Step"
        case .saveGame: return "Save Game"
        case .createGame: return "Create Game"
        case .addSelected: return "Add Selected"
        case .done: return "Done"
        case .chooseCourt: return "Choose Court"
        case .chooseTourney: return "Choose Tourney"
        case .chooseTeam: return "Choose Team"
        case .joinTourney: return "Join a Tourney"
        case .joinGame: return "Join Game"
        case .invitePlayers: return "Invite Players"
        case .addPayment: return "Add Payment"
        case .addFavorite: return "Add Favorite"
        case .ratePlayers: return "Rate Players"
        case .getStarted: return "Get Started"
        case .sendCode: return "Send Code"
        case .verify: return "Verify"
        case .ok: return "OK"
        case .yes: return "Yes"
        case .retry: return "Retry"
        case .update: return "Update"
        case .decline: return "Decline"
        case .details: return "Details"
        case .skip: return "Skip"
        case .unfavorite: return "Unfavorite"
        case .no: return "No"
        }
    }

    var image: UIImage? {
        nil
    }

    func style(for state: AppButtonVisualState) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .primaryNormal
        case .selected:
            return .primarySelected
        case .disabled:
            return .primaryDisabled
        }
    }
}
