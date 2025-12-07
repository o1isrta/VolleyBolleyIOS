//
//  AlertCoordinator.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

protocol AlertCoordinatorProtocol {
    func show(_ descriptor: AlertDescriptor, retry: (() -> Void)?)
}

final class AlertCoordinator: AlertCoordinatorProtocol {

    // MARK: - Private Properties

    private let rootProvider: RootViewControllerProviding
    private let router: AppRouter
    private weak var presentedAlert: AlertViewController?

    // MARK: - Initializers

    init(
        root: RootViewControllerProviding,
        router: AppRouter,
        alertVC: AlertViewController
    ) {
        self.rootProvider = root
        self.router = router
        self.presentedAlert = alertVC
    }

    // MARK: - Public Methods

    func show(_ descriptor: AlertDescriptor, retry: (() -> Void)? = nil) {
        Task { @MainActor in
            self.showOnMain(descriptor, retry: retry)
        }
    }

    // MARK: - Private Methods

    @MainActor
    private func showOnMain(_ descriptor: AlertDescriptor, retry: (() -> Void)?) {
        let alertVC = AlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve

        let models = actionsToModel(descriptor.actions, retry: retry)

        let model = AlertModel(
            title: descriptor.title,
            message: descriptor.message,
            bullets: descriptor.bullets,
            messageAlignment: descriptor.messageAlignment,
            actions: models
        )

        alertVC.configure(with: model)

        rootProvider.rootViewController.present(alertVC, animated: true)
        presentedAlert = alertVC
    }

    private func hide() {
        presentedAlert?.dismiss(animated: false)
        presentedAlert = nil
    }

    private func actionsToModel(_ actions: [AlertAction], retry: (() -> Void)?) -> [AlertActionModel] {
        actions.prefix(2).map { action in
            switch action {

            case .dismiss(let title, let isPrimary, let maxWidthFraction):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction
                ) { [weak self] in
                    self?.hide()
                }

            case .retry(let title, let isPrimary, let maxWidthFraction):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction
                ) { [weak self] in
                    retry?()
                    self?.hide()
                }

            case .relogin(let title, let isPrimary, let maxWidthFraction):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction
                ) { [weak self] in
                    self?.hide()
                    self?.router.showAuthorization()
                }

            case .openMainApp(let title, let isPrimary, let maxWidthFraction):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction
                ) { [weak self] in
                    self?.hide()
                    self?.router.showMainApp()
                }

            case .openSettings(let title, let isPrimary, let maxWidthFraction):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction
                ) { [weak self] in
                    self?.hide()
                    UIApplication.shared.openSettingsURL()
                }

            case .custom(let title, let isPrimary, let maxWidthFraction, let handler):
                return AlertActionModel(
                    title: title,
                    isPrimary: isPrimary,
                    maxWidthFraction: maxWidthFraction,
                    handler: handler
                )
            }
        }
    }
}

extension UIApplication {
    func openSettingsURL() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        open(url)
    }
}
