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
                title: nil,
                message: L10n.Errors.network,
                actions: [
                    .dismiss(title: L10n.Buttons.okay, isPrimary: false),
                    .retry(title: L10n.Buttons.retry, isPrimary: true)
                ]
            )
        case .tooManyRequests:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.tooManyRequests,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        default:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.fallback,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        }
    }

    private func authAlert(for error: DomainError) -> AlertDescriptor? {
        guard case let .auth(authError) = error else { return nil }

        switch authError {
        case .invalidPhoneNumber, .missingPhoneNumber:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.invalidPhone,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .invalidVerificationCode:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.invalidCode,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .sessionExpired:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.sessionExpired,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .tooManyRequests:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.tooManyRequests,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .quotaExceeded:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.quotaExceeded,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .userDisabled:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.userDisabled,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .networkError:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.network,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .invalidCredentials:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.invalidCredentials,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .missingIDToken:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.missingToken,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .signInCancelled:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.signInCancelled,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        case .signInFailed:
            return AlertDescriptor(
                title: nil,
                message: L10n.Errors.signInFailed,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        default:
            return AlertDescriptor(
                title: L10n.Titles.error,
                message: L10n.Errors.fallback,
                actions: [.dismiss(title: L10n.Buttons.okay, isPrimary: true)]
            )
        }
    }

    private func commonAlert(for error: DomainError) -> AlertDescriptor? {
        guard case let .common(commonError) = error else { return nil }

        switch commonError {
        case .notImplemented:
            return AlertDescriptor(
                title: L10n.Titles.warning,
                message: L10n.Errors.notImplemented,
                actions: [
                    .dismiss(title: L10n.Buttons.okay, isPrimary: false, maxWidthFraction: 0.3),
                    .openMainApp(title: L10n.Buttons.mainApp, isPrimary: true)
                ]
            )
        case .notificationDisabled:
            return AlertDescriptor(
                title: L10n.Titles.notifications,
                message: L10n.Errors.StayInLoop.title,
                bullets: [
                    L10n.Errors.StayInLoop.item1,
                    L10n.Errors.StayInLoop.item2,
                    L10n.Errors.StayInLoop.item3
                ],
                messageAlignment: .left,
                actions: [
                    .dismiss(title: L10n.Buttons.skip.uppercased(), isPrimary: false, maxWidthFraction: 0.3),
                    .openSettings(title: L10n.Buttons.enable.uppercased(), isPrimary: true)
                ]
            )
        }
    }
}
