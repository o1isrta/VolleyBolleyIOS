//
//  NewGameOrTourneyAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Swinject

final class NewGameOrTourneyAssembly: Assembly {

	func assemble(container: Container) {
		container.register(NewGameOrTourneyController.self) { _ in
			let newGameOrTourneyVC = NewGameOrTourneyController()
			let interactor = NewGameOrTourneyInteractor()
			let router = NewGameOrTourneyRouter(viewController: newGameOrTourneyVC)
			let presenter = NewGameOrTourneyPresenter(
				interactor: interactor,
				router: router
			)
			newGameOrTourneyVC.presenter = presenter
			interactor.presenter = presenter
			presenter.view = newGameOrTourneyVC

			return newGameOrTourneyVC
		}
	}
}
