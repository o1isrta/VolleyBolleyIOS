//
//  ErrorPolicyEngine.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

protocol ErrorPolicyEngineProtocol {
    func decision(from: DomainError) -> AlertDescriptor?
}

final class ErrorPolicyEngine: ErrorPolicyEngineProtocol {

    func decision(from error: DomainError) -> AlertDescriptor? {
        switch error {
        case .network:
            return networkAlert(for: error)
        case .auth:
            return authAlert(for: error)
        case .common:
            return commonAlert(for: error)
        default:
            return nil
        }
    }

    private func networkAlert(for error: DomainError) -> AlertDescriptor? {
        guard case let .network(networkError) = error else { return nil }

        switch networkError {
        case .networkConnectionLost, .network, .cannotFindHost, .client, .server:
            return AlertDescriptor(
                id: AlertID(rawValue: "network"),
                kind: .network,
                title: nil,
                message: L10n.Errors.network,
                actions: [
                    .init(
                        intent: .dismiss,
                        title: L10n.Buttons.okay,
                        style: .secondary
                    ),
                    .init(
                        intent: .retry,
                        title: L10n.Buttons.retry,
                        style: .primary
                    )
                ],
                presentationPolicy: .ignoreIfPresentingSameKind
            )
        case .tooManyRequests:
            return AlertDescriptor(
                id: AlertID(rawValue: "network"),
                kind: .network,
                title: nil,
                message: L10n.Errors.tooManyRequests,
                actions: [
                    .init(
                        intent: .dismiss,
                        title: L10n.Buttons.okay,
                        style: .primary
                    )
                ],
                presentationPolicy: .queue
            )
        default:
            return AlertDescriptor(
                id: AlertID(rawValue: "network"),
                kind: .network,
                title: nil,
                message: L10n.Errors.fallback,
                actions: [
                    .init(
                        intent: .dismiss,
                        title: L10n.Buttons.okay,
                        style: .primary
                    )
                ],
                presentationPolicy: .ignoreIfPresentingSameKind
            )
        }
    }

    private func authAlert(for error: DomainError) -> AlertDescriptor? {
        guard case let .auth(authError) = error else { return nil }

        let map: [AuthError: (title: String?, message: String)] = [
            .invalidPhoneNumber: (nil, L10n.Errors.invalidPhone),
            .missingPhoneNumber: (nil, L10n.Errors.invalidPhone),
            .invalidVerificationCode: (nil, L10n.Errors.invalidCode),
            .sessionExpired: (nil, L10n.Errors.sessionExpired),
            .tooManyRequests: (nil, L10n.Errors.tooManyRequests),
            .quotaExceeded: (nil, L10n.Errors.quotaExceeded),
            .userDisabled: (nil, L10n.Errors.userDisabled),
            .networkError: (nil, L10n.Errors.network),
            .invalidCredentials: (nil, L10n.Errors.invalidCredentials),
            .missingIDToken: (nil, L10n.Errors.missingToken),
            .signInCancelled: (nil, L10n.Errors.signInCancelled),
            .signInFailed: (nil, L10n.Errors.signInFailed)
        ]

        if let entry = map[authError] {
            return makeAuthAlert(message: entry.message, title: entry.title)
        }

        return makeAuthAlert(
            message: L10n.Errors.fallback,
            title: L10n.Titles.error
        )
    }

    private func commonAlert(for error: DomainError) -> AlertDescriptor? {
        guard case let .common(commonError) = error else { return nil }

        switch commonError {
        case .notImplemented:
            return AlertDescriptor(
                id: AlertID(rawValue: "common"),
                kind: .common,
                title: L10n.Titles.warning,
                message: L10n.Errors.notImplemented,
                actions: [
                    .init(
                        intent: .dismiss,
                        title: L10n.Buttons.okay,
                        style: .secondary,
                    ),
                    .init(
                        intent: .openMainApp,
                        title: L10n.Buttons.mainApp.uppercased(),
                        style: .primary,
                    )
                ],
                presentationPolicy: .queue
            )
        case .notificationDisabled:
            return AlertDescriptor(
                id: AlertID(rawValue: "common"),
                kind: .common,
                title: L10n.Titles.notifications,
                message: L10n.Errors.StayInLoop.title,
                bullets: [
                    L10n.Errors.StayInLoop.item1,
                    L10n.Errors.StayInLoop.item2,
                    L10n.Errors.StayInLoop.item3
                ],
                messageAlignment: .left,
                actions: [
                    .init(
                        intent: .dismiss,
                        title: L10n.Buttons.skip.uppercased(),
                        style: .secondary,
                    ),
                    .init(
                        intent: .openSettings,
                        title: L10n.Buttons.enable.uppercased(),
                        style: .primary,
                    )
                ],
                presentationPolicy: .queue
            )
        }
    }

    private func makeAuthAlert(
        message: String,
        title: String? = nil
    ) -> AlertDescriptor {
        AlertDescriptor(
            id: AlertID(rawValue: "auth"),
            kind: .auth,
            title: title,
            message: message,
            actions: [
                .init(
                    intent: .dismiss,
                    title: L10n.Buttons.okay.uppercased(),
                    style: .primary,
                )
            ],
            presentationPolicy: .queue
        )
    }
}
