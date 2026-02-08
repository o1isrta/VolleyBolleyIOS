//
//  CreateTourneyAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 07.02.2026.
//

import Swinject
import UIKit

final class CreateTourneyAssembly: Assembly {

	// MARK: - Factory Method

	static func createModule(tourneyType: TourneyType) -> CreateTourneyViewController {
		let createTourneyVC = CreateTourneyViewController(tourneyType: tourneyType)
		let interactor = CreateTourneyInteractor()
		let router = CreateTourneyRouter(viewController: createTourneyVC)
		let presenter = CreateTourneyPresenter(
			interactor: interactor,
			router: router
		)

		createTourneyVC.presenter = presenter
		interactor.presenter = presenter
		presenter.view = createTourneyVC

		return createTourneyVC
	}

	// MARK: - Swinject Assembly

	func assemble(container: Container) {
		container.register(CreateTourneyViewController.self) { (_, tourneyType: TourneyType) in
			CreateTourneyAssembly.createModule(tourneyType: tourneyType)
		}
	}
}
