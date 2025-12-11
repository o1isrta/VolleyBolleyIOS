//
//  ErrorAlertDecision.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.12.2025.
//

import Foundation

struct ErrorAlertDecision {
    let id: String
    let kind: AlertKind
    let titleKey: TitleL10nKey?
    let messageKey: ErrorL10nKey
    let bulletKeys: [ErrorL10nKey]?
    let actionIntents: [AlertAction]
    let policy: PresentationPolicy
}

enum PresentationPolicy {
    case ignoreIfPresentingSameKind
    case replaceCurrent
    case queue
}
