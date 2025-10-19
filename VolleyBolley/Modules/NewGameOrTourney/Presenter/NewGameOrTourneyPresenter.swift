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
	func getICellsCount() -> Int
	func getCellType(index: Int) -> GameCellType
}

final class NewGameOrTourneyPresenter: NewGameOrTourneyPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NewGameOrTourneyViewControllerProtocol?

	let interactor: NewGameOrTourneyInteractorProtocol
	let router: NewGameOrTourneyRouterProtocol

	// MARK: - Private Properties

	private let gameType: GameType = .game// TODO: -

	// MARK: - Initializers

	init(
		interactor: NewGameOrTourneyInteractorProtocol,
		router: NewGameOrTourneyRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	func viewDidLoad() {
		view?.setupTitle(with: gameType.title)
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func getICellsCount() -> Int {
		gameType.cells.count
	}

	func getCellType(index: Int) -> GameCellType {
		gameType.cells[index]
	}
}
