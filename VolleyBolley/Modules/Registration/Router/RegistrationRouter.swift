//
//  RegistrationRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import UIKit

protocol RegistrationRouterProtocol: AnyObject {
	func navigateToNextScreen()
	func showLevelInfoScreen()
}

final class RegistrationRouter: RegistrationRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?
	// TODO: - 
//	private weak var router: AppRouter?

	// MARK: - Initializers

	init(
		viewController: UIViewController
//		router: AppRouter?
	) {
		self.viewController = viewController
//		self.router = router
	}

	// MARK: - Public Methods

	func navigateToNextScreen() {
		// TODO: - Сделать переход на следующий экран
	}

	func showLevelInfoScreen() {
		let levelVC = LevelInfoViewController()
		levelVC.modalPresentationStyle = .overFullScreen
		levelVC.modalTransitionStyle = .crossDissolve

		viewController?.present(levelVC, animated: true)
	}
}
