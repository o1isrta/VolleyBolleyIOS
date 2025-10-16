//
//  NewGameAndTourneyRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameAndTourneyRouterProtocol: AnyObject {
	func navigateBack()
}

final class NewGameAndTourneyRouter: NewGameAndTourneyRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	// MARK: - Initializers

	init(viewController: UIViewController) {
		self.viewController = viewController
	}

	// MARK: - Public Methods

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
