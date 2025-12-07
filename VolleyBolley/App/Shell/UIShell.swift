//
//  UIShell.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

protocol UIShellProtocol {
    func showAlert(_ error: DomainError, retry: (() -> Void)?)
    func showAlert(_ error: DomainError)
}

final class UIShell: UIShellProtocol {

    private let policy: ErrorPolicyEngineProtocol
    private let alertCoordinator: AlertCoordinatorProtocol

    init(policy: ErrorPolicyEngineProtocol, alertCoordinator: AlertCoordinatorProtocol) {
        self.policy = policy
        self.alertCoordinator = alertCoordinator
    }

    func showAlert(_ error: DomainError, retry: (() -> Void)? = nil) {
        Task { @MainActor in
            self.presentAlert(error, retry: retry)
        }
    }

    func showAlert(_ error: DomainError) {
        showAlert(error, retry: nil)
    }

    @MainActor
    private func presentAlert(_ error: DomainError, retry: (() -> Void)?) {
        guard let descriptor = policy.decision(from: error) else { return }

        alertCoordinator.show(descriptor, retry: retry)
    }
}
