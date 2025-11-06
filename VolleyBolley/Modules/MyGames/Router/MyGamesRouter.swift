//
//  MyGamesRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import UIKit

protocol MyGamesRouterProtocol: AnyObject {
    func start() -> UIViewController
	func showMyGames()
	func showUpcomingGames()
	func showGameInvites()
	func showArchive()
}

final class MyGamesRouter: MyGamesRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Private Properties

    private let viewControllerFactory: () -> UIViewController

    private weak var navigationController: UINavigationController?

    // MARK: - Initializers

    init(
        viewControllerFactory: @escaping () -> UIViewController,
    ) {
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let rootVC = viewControllerFactory()
        let nav = UINavigationController(rootViewController: rootVC)
        navigationController = nav
        return nav
    }

	func showMyGames() {
		print("open My Games")
	}

	func showUpcomingGames() {
		print("open Upcoming Games")
	}

	func showGameInvites() {
		print("open Game Invites")
	}

	func showArchive() {
		print("open Archive")
	}
}
