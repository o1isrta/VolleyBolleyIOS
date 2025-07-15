//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Swinject
import UIKit

protocol OnboardingRouterProtocol {
    var onFinish: (() -> Void)? { get set }
    func start() -> UIViewController
}

class OnboardingRouter: OnboardingRouterProtocol {
    var onFinish: (() -> Void)?

    private let resolver: Resolver
    private weak var viewController: UIViewController?

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func start() -> UIViewController {
        guard let view = resolver.resolve(OnboardingViewController.self) else {
            fatalError("Failed to resolve OnboardingViewController")
        }

        viewController = view

        return view
    }
}
