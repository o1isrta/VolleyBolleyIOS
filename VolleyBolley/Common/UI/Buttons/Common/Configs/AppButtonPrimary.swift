//
//  AppButtonPrimary.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 19.07.2025.
//

import UIKit

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
    case confirm
    case cancel
    case yes
    case retry
    case update
    case decline
    case details
    case skip
    case unfavorite
    case chooseGame
    case cancelGame
}

// MARK: - AppButtonConfig

extension AppButtonPrimary: AppButtonConfig {

    var actionImage: UIImage? { nil }
    var actionTitle: String? { nil }
    var image: UIImage? { nil }

    var title: String? {
        String(localized: String.LocalizationValue(localizationKey)).uppercased()
    }

    func style(for state: UIControl.State) -> AppButtonStyle? {
        switch state {
        case .normal:
            return .primaryNormal
        case .selected:
            return .primarySelected
        case .disabled:
            return .primaryDisabled
        case [.selected, .highlighted]:
            return .primaryHighlightedSelected
        case [.normal, .highlighted]:
            return .primaryHighlightedNormal
        default:
            return .primaryNormal
        }
    }
}

private extension AppButtonPrimary {
    var localizationKey: String {
        switch self {
        case .save: return String(localized: "common.save")
        case .nextStep: return String(localized: "common.nextStep")
        case .saveGame: return String(localized: "common.saveGame")
        case .createGame: return String(localized: "common.createGame")
        case .addSelected: return String(localized: "common.addSelected")
        case .done: return String(localized: "common.done")
        case .chooseCourt: return String(localized: "common.chooseCourt")
        case .chooseTourney: return String(localized: "common.chooseTourney")
        case .chooseTeam: return String(localized: "common.chooseTeam")
        case .joinTourney: return String(localized: "common.joinTourney")
        case .joinGame: return String(localized: "common.joinGame")
        case .invitePlayers: return String(localized: "common.invitePlayers")
        case .addPayment: return String(localized: "common.addPayment")
        case .addFavorite: return String(localized: "common.addFavorite")
        case .ratePlayers: return String(localized: "common.ratePlayers")
        case .getStarted: return String(localized: "common.getStarted")
        case .sendCode: return String(localized: "common.sendCode")
        case .verify: return String(localized: "common.verify")
        case .confirm: return String(localized: "common.ok")
        case .yes: return String(localized: "common.yes")
        case .retry: return String(localized: "common.retry")
        case .update: return String(localized: "common.update")
        case .decline: return String(localized: "common.decline")
        case .details: return String(localized: "common.details")
        case .skip: return String(localized: "common.skip")
        case .unfavorite: return String(localized: "common.unfavorite")
        case .cancel: return String(localized: "common.no")
        case .chooseGame: return String(localized: "common.chooseGame")
        case .cancelGame: return String(localized: "common.cancelGame")
        }
    }
}
