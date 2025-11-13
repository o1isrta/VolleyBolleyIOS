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
	func navigateToMap(coordinates: Coordinates)
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

	func navigateToMap(coordinates: Coordinates) {
		// TODO: - open map with coordinates
		print("open map at location:", coordinates)
	}
}
