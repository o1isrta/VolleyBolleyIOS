//
//  NewGameOrTourneyPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import Foundation

protocol NewGameOrTourneyPresenterProtocol: AnyObject {
	var view: NewGameOrTourneyViewControllerProtocol? { get set }
	var router: NewGameOrTourneyRouterProtocol { get }
	var location: LocationTitleViewModel { get }

	func viewDidLoad()
	func backButtonTapped()
	func nextButtonTapped()
	func setupCreateGameWith(type: GameType, court: CourtModel)
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

	let router: NewGameOrTourneyRouterProtocol

	// MARK: - Private Properties

	private var gameType: GameType = .game
	private(set) var location: LocationTitleViewModel = .init(title: "", location: "")

	private var message: String?
	private var dateRange: GameDateRange?
	private var tourneyType: GameTourneyType?
	private var gender: GameGenderType = .mix
	private var playerLevels: [PlayerLevel] = []

	// MARK: - Initializers

	init(
		router: NewGameOrTourneyRouterProtocol
	) {
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		view?.setupTitle(with: gameType.title)
	}

	func setupCreateGameWith(type: GameType, court: CourtModel) {
		gameType = type
		location = LocationTitleViewModel(
			title: court.location.courtName,
			location: court.location.locationName
		)
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func nextButtonTapped() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		// TODO: - тут нужно собрать модель и отправить данные на следующий экран
		print("router.nextButtonTapped()")
		print("gameType", gameType)
		print("message", message)
		print("dateRange", dateRange)
		print("tourneyType", tourneyType)
		print("gender", gender)
		print("playerLevels", playerLevels)
	}

	func getICellsCount() -> Int {
		gameType.cells.count
	}

	func getCellType(index: Int) -> GameCellType {
		gameType.cells[index]
	}

	func setupMessage(_ message: String) {
		self.message = message
	}

	func setupDateRange(_ dateRange: GameDateRange) {
		self.dateRange = dateRange
		validateData()
	}

	func setupTourneyType(to tourneyType: GameTourneyType) {
		self.tourneyType = tourneyType
		validateData()
	}

	func setupGender(to gender: GameGenderType) {
		self.gender = gender
		validateData()
	}

	func setupPlayerLevels(to playerLevels: [PlayerLevel]) {
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
