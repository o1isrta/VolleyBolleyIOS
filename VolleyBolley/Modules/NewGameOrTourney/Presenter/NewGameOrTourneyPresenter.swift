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
	func setupMessage(_ message: String)
	func getLocation() -> LocationTitleViewModel
	func setupDateRange(_ dateRange: GameDateRange)
	func setupTourneyType(to tourneyType: GameTourneyType)
	func setupGender(to gender: GameGenderType)
	func setupPlayerLevels(to playerLevels: [PlayerLevel])
}

final class NewGameOrTourneyPresenter: NewGameOrTourneyPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NewGameOrTourneyViewControllerProtocol?

	let interactor: NewGameOrTourneyInteractorProtocol
	let router: NewGameOrTourneyRouterProtocol

	// MARK: - Private Properties

	private let gameType: GameType = .game// TODO: -

	private var message: String?
	private var dateRange: GameDateRange?
	private var tourneyType: GameTourneyType?
	private var gender: GameGenderType = .mix
	private var playerLevels: [PlayerLevel] = []

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

	func setupMessage(_ message: String) {
		self.message = message
		print("Current message: \(message)")// TODO: -
	}

	func getLocation() -> LocationTitleViewModel {
		// TODO: -
		LocationTitleViewModel(
			title: "Karon Beach Club",
			location: "Patak Rd, Mueang Phuket"
		)
	}

	func setupDateRange(_ dateRange: GameDateRange) {
		print("setupDateRange: \(dateRange)")// TODO: -
		self.dateRange = dateRange
	}

	func setupTourneyType(to tourneyType: GameTourneyType) {
		print("setupTourneyType: \(tourneyType)")// TODO: -
		self.tourneyType = tourneyType
	}

	func setupGender(to gender: GameGenderType) {
		print("setupGender: \(gender)")// TODO: -
		self.gender = gender
	}

	func setupPlayerLevels(to playerLevels: [PlayerLevel]) {
		print("setupPlayerLevels: \(playerLevels)")// TODO: -
		self.playerLevels = playerLevels
	}
}
