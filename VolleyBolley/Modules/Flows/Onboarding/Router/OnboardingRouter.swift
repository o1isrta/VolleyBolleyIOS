//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    func start() -> UIViewController
    func finishOnboarding()
    var delegate: OnboardingRouterDelegate? { get set }
}

protocol OnboardingRouterDelegate: AnyObject {
    func onboardingDidFinish()
}

final class OnboardingRouter: OnboardingRouterProtocol {

    // MARK: - Public Properties

    weak var delegate: OnboardingRouterDelegate?

    // MARK: - Private Properties

    private let viewControllerFactory: () -> UIViewController

    // MARK: - Initializers

    init(viewControllerFactory: @escaping () -> UIViewController) {
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        viewControllerFactory()
    }

    func finishOnboarding() {
        delegate?.onboardingDidFinish()
    }
}
