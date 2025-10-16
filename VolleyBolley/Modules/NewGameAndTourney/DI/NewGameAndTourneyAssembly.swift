//
//  NewGameAndTourneyAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Swinject

final class NewGameAndTourneyAssembly: Assembly {

	func assemble(container: Container) {
		container.register(NewGameAndTourneyController.self) { _ in
			let newGameAndTourneyVC = NewGameAndTourneyController()
			let interactor = NewGameAndTourneyInteractor()
			let router = NewGameAndTourneyRouter(viewController: newGameAndTourneyVC)
			let presenter = NewGameAndTourneyPresenter(
				interactor: interactor,
				router: router
			)
			newGameAndTourneyVC.presenter = presenter
			interactor.presenter = presenter
			presenter.view = newGameAndTourneyVC

			return newGameAndTourneyVC
		}
	}
}
