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

    func showLoader()
    func hideLoader()
}

final class UIShell: UIShellProtocol {

    // MARK: - Private properties

    private let policy: ErrorPolicyEngineProtocol
    private let mapper: AlertMapperProtocol
    private let alertCoordinator: AlertCoordinatorProtocol
    private let loaderCoordinator: LoaderCoordinatorProtocol

    // MARK: - Initializers

    init(
        policy: ErrorPolicyEngineProtocol,
        mapper: AlertMapperProtocol,
        alertCoordinator: AlertCoordinatorProtocol,
        loaderCoordinator: LoaderCoordinatorProtocol
    ) {
        self.policy = policy
        self.mapper = mapper
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
        guard let decision = policy.decision(from: error) else { return }

        let descriptor = mapper.map(decision)

        alertCoordinator.show(descriptor, retry: retry)
    }

    @MainActor
    private func presentLoader() {
        loaderCoordinator.show()
    }
}
