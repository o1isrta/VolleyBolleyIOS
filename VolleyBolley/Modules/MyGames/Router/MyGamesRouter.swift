//
//  MyGamesRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import UIKit

protocol MyGamesRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
	func showMyGames()
	func showUpcomingGames()
	func showGameInvites()
	func showArchive()
}

final class MyGamesRouter: MyGamesRouterProtocol {

	// MARK: - Public Properties

    weak var viewController: UIViewController?

	// MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
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
