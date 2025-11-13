//
//  UserCardRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import UIKit

// MARK: - UserCardRouterProtocol

protocol UserCardRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func navigateBack()
}

// MARK: - UserCardRouter

final class UserCardRouter: UserCardRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
