//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

protocol OnboardingRouterProtocol {
    var onFinish: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class OnboardingRouter: OnboardingRouterProtocol {

    // MARK: - Public Properties

    var onFinish: (() -> Void)?

    // MARK: - Private Properties

    private let resolver: Resolver

    // MARK: - Initializers

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        guard let viewController = resolver.resolve(OnboardingViewController.self) else {
            fatalError("Error: Failed to resolve AuthViewController")
        }

        viewController.onContinue = { [weak self] in
            self?.onFinish?()
        }

        return viewController
    }
}
