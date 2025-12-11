//
//  ErrorPolicyEngine.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

protocol ErrorPolicyEngineProtocol {
    func decision(from error: DomainError) -> ErrorAlertDecision?
}

final class ErrorPolicyEngine: ErrorPolicyEngineProtocol {

    func decision(from error: DomainError) -> ErrorAlertDecision? {
        switch error {
        case .network(let error): return networkDecision(error)
        case .auth(let error): return authDecision(error)
        case .common(let error): return commonDecision(error)
        default: return nil
        }
    }

    private func networkDecision(_ error: NetworkError) -> ErrorAlertDecision {
        switch error {
        case .tooManyRequests:
            return ErrorAlertDecision(
                id: "network",
                kind: .network,
                titleKey: nil,
                messageKey: .tooManyRequests,
                bulletKeys: nil,
                actionIntents: [
                    .init(intent: .dismiss, titleKey: .okay, style: .primary)
                ],
                policy: .queue
            )
        default:
            return ErrorAlertDecision(
                id: "network",
                kind: .network,
                titleKey: nil,
                messageKey: .network,
                bulletKeys: nil,
                actionIntents: [
                    .init(intent: .dismiss, titleKey: .okay, style: .secondary),
                    .init(intent: .retry, titleKey: .retry, style: .primary)
                ],
                policy: .ignoreIfPresentingSameKind
            )
        }
    }

    private func authDecision(_ error: AuthError) -> ErrorAlertDecision {
        let map: [AuthError: (titleKey: TitleL10nKey?, messageKey: ErrorL10nKey)] = [
            .invalidPhoneNumber: (nil, .invalidPhone),
            .missingPhoneNumber: (nil, .invalidPhone),
            .invalidVerificationCode: (nil, .invalidCode),
            .sessionExpired: (nil, .sessionExpired),
            .tooManyRequests: (nil, .tooManyRequests),
            .quotaExceeded: (nil, .quotaExceeded),
            .userDisabled: (nil, .userDisabled),
            .networkError: (nil, .network),
            .invalidCredentials: (nil, .invalidCredentials),
            .missingIDToken: (nil, .missingToken),
            .signInCancelled: (nil, .signInCancelled),
            .signInFailed: (nil, .signInFailed)
        ]

        if let entry = map[error] {
            return makeAuthAlertDecision(messageKey: entry.messageKey, titleKey: entry.titleKey)
        }

        return makeAuthAlertDecision(
            messageKey: .fallback,
            titleKey: .error
        )
    }

    private func commonDecision(_ error: CommonError) -> ErrorAlertDecision {
        switch error {
        case .notImplemented:
            return ErrorAlertDecision(
                id: "common",
                kind: .common,
                titleKey: .warning,
                messageKey: .notImplemented,
                bulletKeys: nil,
                actionIntents: [
                    .init(intent: .dismiss, titleKey: .okay, style: .secondary),
                    .init(intent: .openMainApp, titleKey: .mainApp, style: .primary)
                ],
                policy: .queue
            )
        case .notificationDisabled:
            return ErrorAlertDecision(
                id: "common",
                kind: .common,
                titleKey: .notifications,
                messageKey: .notificationDisabled,
                bulletKeys: [
                    .notificationDisabledItem1,
                    .notificationDisabledItem2,
                    .notificationDisabledItem3
                ],
                actionIntents: [
                    .init(intent: .dismiss, titleKey: .skip, style: .secondary),
                    .init(intent: .openSettings, titleKey: .enable, style: .primary)
                ],
                policy: .queue
            )
        }
    }

    // MARK: - Helpers

    private func makeAuthAlertDecision(messageKey: ErrorL10nKey, titleKey: TitleL10nKey? = nil) -> ErrorAlertDecision {
        ErrorAlertDecision(
            id: "auth",
            kind: .auth,
            titleKey: titleKey,
            messageKey: messageKey,
            bulletKeys: nil,
            actionIntents: [
                .init(intent: .dismiss, titleKey: .okay, style: .primary)
            ],
            policy: .queue
        )
    }
}
