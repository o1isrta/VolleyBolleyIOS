//
//  PlayersListRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 28.11.2025.
//

import UIKit

// MARK: - PlayersListRouterProtocol

protocol PlayersListRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func navigateBack()
	func navigateToUserCard()
}

// MARK: - PlayersListRouter

final class PlayersListRouter: PlayersListRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func navigateToUserCard() {
		// TODO: - open UserCard with data
		print("open user card")
	}
}
