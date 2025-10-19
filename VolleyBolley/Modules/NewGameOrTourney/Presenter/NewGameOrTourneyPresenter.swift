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
	var location: LocationTitleViewModel { get }

	func viewDidLoad()
	func backButtonTapped()
	func nextButtonTapped()
	func getICellsCount() -> Int
	func getCellType(index: Int) -> GameCellType
	func setupMessage(_ message: String)
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
	private(set) var location: LocationTitleViewModel// TODO: -

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
		// TODO: -
		location = LocationTitleViewModel(
			title: "Karon Beach Club",
			location: "Patak Rd, Mueang Phuket"
		)
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		view?.setupTitle(with: gameType.title)
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func nextButtonTapped() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		print("router.nextButtonTapped()")// TODO: -
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

	func setupDateRange(_ dateRange: GameDateRange) {
		print("setupDateRange: \(dateRange)")// TODO: -
		self.dateRange = dateRange
		validateData()
	}

	func setupTourneyType(to tourneyType: GameTourneyType) {
		print("setupTourneyType: \(tourneyType)")// TODO: -
		self.tourneyType = tourneyType
		validateData()
	}

	func setupGender(to gender: GameGenderType) {
		print("setupGender: \(gender)")// TODO: -
		self.gender = gender
		validateData()
	}

	func setupPlayerLevels(to playerLevels: [PlayerLevel]) {
		print("setupPlayerLevels: \(playerLevels)")// TODO: -
		self.playerLevels = playerLevels
		validateData()
	}
}

// MARK: - Private Methods

private extension NewGameOrTourneyPresenter {

	func validateData() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		view?.allowNextStep(true)
	}

	func checkData() -> Bool {
		guard checkGeneralRequirements() else { return false }
		return checkTourneyRequirements()
	}

	func checkGeneralRequirements() -> Bool {
		guard
			let _ = dateRange,
			!playerLevels.isEmpty
		else {
			return false
		}

		return true
	}

	func checkTourneyRequirements() -> Bool {
		if gameType == .tourney,
		   tourneyType == nil {
			return false
		}

		return true
	}
}
