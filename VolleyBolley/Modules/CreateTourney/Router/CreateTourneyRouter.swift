//
//  CreateTourneyRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.02.2026.
//

import UIKit

protocol CreateTourneyRouterProtocol: AnyObject {
	func navigateBack()
}

final class CreateTourneyRouter: CreateTourneyRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	// MARK: - Initializers

	init(
		viewController: UIViewController
	) {
		self.viewController = viewController
	}

	// MARK: - Public Methods

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
