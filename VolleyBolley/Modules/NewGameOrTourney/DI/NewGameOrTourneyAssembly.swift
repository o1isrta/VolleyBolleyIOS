//
//  NewGameOrTourneyAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Swinject
import UIKit

final class NewGameOrTourneyAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(with parentViewController: UIViewController?) -> NewGameOrTourneyViewController {
		let newGameOrTourneyVC = NewGameOrTourneyViewController()
		let router = NewGameOrTourneyRouter(viewController: newGameOrTourneyVC)
		let presenter = NewGameOrTourneyPresenter(
			router: router
		)
		newGameOrTourneyVC.presenter = presenter
		presenter.view = newGameOrTourneyVC

		return newGameOrTourneyVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(NewGameOrTourneyViewController.self) { _ in
			let newGameOrTourneyVC = NewGameOrTourneyViewController()
			let router = NewGameOrTourneyRouter(viewController: newGameOrTourneyVC)
			let presenter = NewGameOrTourneyPresenter(
				router: router
			)
			newGameOrTourneyVC.presenter = presenter
			presenter.view = newGameOrTourneyVC

			return newGameOrTourneyVC
		}
	}
}
