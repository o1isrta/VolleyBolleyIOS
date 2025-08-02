//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Swinject
import UIKit

class OnboardingRouter: OnboardingRouterProtocol {

    var onFinish: (() -> Void)?

    private let resolver: Resolver
    private weak var viewController: UIViewController?

    // MARK: - Initializers

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        guard let view = resolver.resolve(OnboardingViewController.self) else {
            fatalError("Failed to resolve OnboardingViewController")
        }

        viewController = view

        return view
    }
}
