//
//  AlertMapper.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 10.12.2025.
//

import Foundation

protocol AlertMapperProtocol {
    func map(_ decision: ErrorAlertDecision) -> AlertDescriptor
}

final class AlertMapper: AlertMapperProtocol {

    // MARK: - Public methods

    func map(_ decision: ErrorAlertDecision) -> AlertDescriptor {
        AlertDescriptor(
            id: AlertID(rawValue: decision.id),
            kind: decision.kind,
            title: decision.titleKey.map { L10n.localized($0.rawValue) },
            message: L10n.localized(decision.messageKey.rawValue),
            bullets: decision.bulletKeys?.map { L10n.localized($0.rawValue) },
            messageAlignment: .center,
            actions: decision.actionIntents.map(mapAction),
            presentationPolicy: mapPolicy(decision.policy)
        )
    }

    // MARK: - Private methods

    private func mapAction(_ action: AlertAction) -> AlertActionDescriptor {
        AlertActionDescriptor(
            intent: action.intent,
            title: L10n.localized(action.titleKey.rawValue),
            style: mapStyle(action.style)
        )
    }

    private func mapPolicy(_ policy: PresentationPolicy) -> AlertPresentationPolicy {
        switch policy {
        case .queue: return .queue
        case .replaceCurrent: return .replaceCurrent
        case .ignoreIfPresentingSameKind: return .ignoreIfPresentingSameKind
        }
    }

    private func mapStyle(_ style: AlertActionStyle) -> AlertActionStyleDescriptor {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        }
    }
}
