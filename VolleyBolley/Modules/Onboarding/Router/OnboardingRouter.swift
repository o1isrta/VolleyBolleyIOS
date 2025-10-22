//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
	func navigateToAuthorizationScreen()
}

final class OnboardingRouter: OnboardingRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?
	weak var router: AppRouter?

	// MARK: - Initializers

	init(viewController: UIViewController, router: AppRouter?) {
		self.viewController = viewController
		self.router = router
	}

	// MARK: - Public Methods

	func navigateToAuthorizationScreen() {
		router?.start()
	}
}
