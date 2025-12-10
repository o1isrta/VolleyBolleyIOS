//
//  UIShell.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Foundation

final class UIShell: UIShellProtocol {

    // MARK: - Private properties

    private let policy: ErrorPolicyEngineProtocol
    private let alertCoordinator: AlertCoordinatorProtocol
    private let loaderCoordinator: LoaderCoordinatorProtocol

    // MARK: - Initializers

    init(
        policy: ErrorPolicyEngineProtocol,
        alertCoordinator: AlertCoordinatorProtocol,
        loaderCoordinator: LoaderCoordinatorProtocol
    ) {
        self.policy = policy
        self.alertCoordinator = alertCoordinator
        self.loaderCoordinator = loaderCoordinator
    }

    // MARK: - Public methods

    func showAlert(_ error: DomainError, retry: (() -> Void)? = nil) {
        Task { @MainActor in
            self.presentAlert(error, retry: retry)
        }
    }

    func showAlert(_ error: DomainError) {
        showAlert(error, retry: nil)
    }

    func showLoader() {
        Task { @MainActor in
            loaderCoordinator.show()
        }
    }

    func hideLoader() {
        loaderCoordinator.hide()
    }

    // MARK: - Private methods

    @MainActor
    private func presentAlert(_ error: DomainError, retry: (() -> Void)?) {
        guard let descriptor = policy.decision(from: error) else { return }

        alertCoordinator.show(descriptor, retry: retry)
    }

    @MainActor
    private func presentLoader() {
        loaderCoordinator.show()
    }
}
