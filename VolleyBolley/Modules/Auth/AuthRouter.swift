//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

protocol AuthRouterProtocol {
    var onLoginSuccess: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class AuthRouter: AuthRouterProtocol {

    // MARK: - Public Properties

    var onLoginSuccess: (() -> Void)?

    // MARK: - Private Properties

    private let resolver: Resolver

    // MARK: - Initializers
    init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        guard let viewController = resolver.resolve(AuthViewController.self) else {
            fatalError("Error: Failed to resolve AuthViewController")
        }

        viewController.onLogin = { [weak self] in
            self?.onLoginSuccess?()
        }

        return UINavigationController(rootViewController: viewController)
    }
}
