//
//  LoaderCoordinator.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.12.2025.
//

import UIKit

protocol LoaderCoordinatorProtocol {
    func show()
    func hide()
}

final class LoaderCoordinator: LoaderCoordinatorProtocol {

    // MARK: - Private Properties

    private let rootProvider: RootViewControllerProviding
    private let router: AppRouter

    // MARK: - Initializers

    init(root: RootViewControllerProviding, router: AppRouter) {
        self.rootProvider = root
        self.router = router
    }

    // MARK: - Public Methods

    func show() {
        Task { @MainActor [weak self] in
            await self?.showOnMain()
        }
    }

    func hide() {
        Task { @MainActor [weak self] in
            await self?.hideOnMain()
        }
    }

    // MARK: - Private Methods

    @MainActor
    private func showOnMain() async {
        let loaderViewController = LoaderViewController()

        loaderViewController.modalPresentationStyle = .overFullScreen
        loaderViewController.modalTransitionStyle = .crossDissolve

        rootProvider.rootViewController.present(loaderViewController, animated: false)
    }

    @MainActor
    private func hideOnMain() async {
        rootProvider.rootViewController.dismiss(animated: false)
    }
}
