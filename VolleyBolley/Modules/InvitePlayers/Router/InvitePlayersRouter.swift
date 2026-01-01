//
//  InvitePlayersRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.01.2026.
//

import Foundation
import UIKit

// MARK: - InvitePlayersRouterProtocol

protocol InvitePlayersRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func navigateBack()
}

// MARK: - PlayersListRouter

final class InvitePlayersRouter: InvitePlayersRouterProtocol {

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
