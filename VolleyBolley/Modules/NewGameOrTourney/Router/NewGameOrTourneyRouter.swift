//
//  NewGameOrTourneyRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameOrTourneyRouterProtocol: AnyObject {
	func navigateBack()
}

final class NewGameOrTourneyRouter: NewGameOrTourneyRouterProtocol {

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
