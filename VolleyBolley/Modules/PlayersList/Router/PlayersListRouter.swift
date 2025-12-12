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
	func openUserCard(for player: UserInfoModel)
}

// MARK: - PlayersListRouter

final class PlayersListRouter: PlayersListRouterProtocol {

	// MARK: - Private Properties

	private weak var viewController: UIViewController?

	private let userCardFactory: (UserInfoModel) -> UserCardViewController?

	// MARK: - Initializers

	init(
		userCardFactory: @escaping (UserInfoModel) -> UserCardViewController?
	) {
		self.userCardFactory = userCardFactory
	}

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func openUserCard(for player: UserInfoModel) {
		guard let userCardVC = userCardFactory(player) else {
			fatalError("UserCardViewController could not be created")
		}
		viewController?.navigationController?.pushViewController(userCardVC, animated: true)
	}
}
