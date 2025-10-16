//
//  NewGameOrTourneyPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameOrTourneyPresenterProtocol: AnyObject {
	var view: NewGameOrTourneyViewControllerProtocol? { get set }
	var interactor: NewGameOrTourneyInteractorProtocol { get }
	var router: NewGameOrTourneyRouterProtocol { get }

	func viewDidLoad()
	func backButtonTapped()
}

final class NewGameOrTourneyPresenter: NewGameOrTourneyPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NewGameOrTourneyViewControllerProtocol?

	let interactor: NewGameOrTourneyInteractorProtocol
	let router: NewGameOrTourneyRouterProtocol

	// MARK: - Initializers

	init(
		interactor: NewGameOrTourneyInteractorProtocol,
		router: NewGameOrTourneyRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	func viewDidLoad() {
		let title = String(localized: "newGameOrTourney.title.tourney")
//		let title = String(localized: "newGameOrTourney.title.game")
		view?.setupTitle(with: title)
	}

	func backButtonTapped() {
		router.navigateBack()
	}
}
