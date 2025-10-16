//
//  NewGameAndTourneyPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameAndTourneyPresenterProtocol: AnyObject {
	var view: NewGameAndTourneyControllerProtocol? { get set }
	var interactor: NewGameAndTourneyInteractorProtocol { get }
	var router: NewGameAndTourneyRouterProtocol { get }

	func viewDidLoad()
	func backButtonTapped()
}

final class NewGameAndTourneyPresenter: NewGameAndTourneyPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NewGameAndTourneyControllerProtocol?

	let interactor: NewGameAndTourneyInteractorProtocol
	let router: NewGameAndTourneyRouterProtocol

	// MARK: - Initializers

	init(
		interactor: NewGameAndTourneyInteractorProtocol,
		router: NewGameAndTourneyRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	func viewDidLoad() {
	}

	func backButtonTapped() {
		router.navigateBack()
	}
}
