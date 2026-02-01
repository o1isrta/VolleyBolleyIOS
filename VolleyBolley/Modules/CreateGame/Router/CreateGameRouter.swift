//
//  CreateGameRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 29.08.2025.
//

import UIKit

protocol CreateGameRouterProtocol: AnyObject {
	func navigateBack()
}

final class CreateGameRouter: CreateGameRouterProtocol {

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
