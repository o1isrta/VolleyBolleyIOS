//
//  RegistrationPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 17.01.2026.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
	var view: RegistrationViewControllerProtocol? { get set }
	var router: RegistrationRouterProtocol { get }
	var location: LocationTitleViewModel { get }

	func viewDidLoad()
	func didTapLevelInfo()
	func nextButtonTapped()
	func getICellsCount() -> Int
	func getCellType(index: Int) -> RegistrationCellType
	func setupGender(to gender: RegistrationGenderType)
	func setupBirthday(to date: String)
	func setupPlayerLevel(to playerLevels: PlayerLevel)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {

	// MARK: - Public Properties

	weak var view: RegistrationViewControllerProtocol?

	let router: RegistrationRouterProtocol

	// MARK: - Private Properties

	// TODO: -
	#if DEBUG
	private(set) var location: LocationTitleViewModel = LocationTitleViewModel(
		title: "Karon Beach Club",
		location: "Patak Rd, Mueang Phuket"
	)
	#else
	private(set) var location: LocationTitleViewModel = .init(title: "", location: "")
	#endif

	private var gender: RegistrationGenderType?
	private var birthday: String?
	private var playerLevel: PlayerLevel?

	// MARK: - Initializers

	init(
		router: RegistrationRouterProtocol
	) {
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		// TODO: -
//		interactor.fetchCountries()
	}

	func didTapLevelInfo() {
		router.showLevelInfoScreen()
	}

	func nextButtonTapped() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}

		guard validateGameDates() else {
			view?.allowNextStep(false)
			return
		}
		// TODO: - тут нужно собрать модель и отправить данные на следующий экран
		print("router.nextButtonTapped()")
		print("birthday", birthday)
		print("gender", gender)
		print("playerLevel", playerLevel)
	}

	func getICellsCount() -> Int {
		RegistrationCellType.allCases.count
	}

	func getCellType(index: Int) -> RegistrationCellType {
		RegistrationCellType.allCases[index]
	}

	func setupGender(to gender: RegistrationGenderType) {
		self.gender = gender
		validateData()
	}

	func setupBirthday(to date: String) {
		self.birthday = date
		validateData()
	}

	func setupPlayerLevel(to playerLevel: PlayerLevel) {
		self.playerLevel = playerLevel
		validateData()
	}
}

// MARK: - Private Methods

private extension RegistrationPresenter {

	func validateData() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		view?.allowNextStep(true)
	}

	func checkData() -> Bool {
		checkGeneralRequirements()
	}

	func checkGeneralRequirements() -> Bool {
		// TODO: -
		guard
			let _ = birthday,
			playerLevel == nil,
			!location.title.isEmpty,
			!location.location.isEmpty
		else {
			return false
		}

		return true
	}

	func validateGameDates() -> Bool {
		// TODO: -
//		guard let dateRange else { return false }
//
//		do {
//			try GameTimeValidator.validate(gameType: gameType, start: dateRange.startTime, end: dateRange.endTime)
//			return true
//		} catch {
//			view?.showAlert(with: error.localizedDescription)
//		}

		return false
	}
}

// TODO: -

/*
protocol RegistrationPresenterProtocol: AnyObject {
	var countries: [String] { get }
	var cities: [String] { get }

	func viewDidLoad()
	func didTapLevelInfo()
	func didTapGetStarted(name: String, surname: String, gender: String)
	func getICellsCount() -> Int
	func getCellType(index: Int) -> GameCellType
	func setupGender(to gender: GameGenderType)
	func setupPlayerLevels(to playerLevels: [PlayerLevel])
}

final class RegistrationPresenter: RegistrationPresenterProtocol {

	private var gameType: GameType = .game
	private var gender: GameGenderType = .mix
	private var playerLevels: [PlayerLevel] = []

	var countries = ["Cyprus", "Thailand"]
	let cities = ["Koh Phangan", "Koh Samui"]

	weak var view: RegistrationViewControllerProtocol?
	var interactor: RegistrationInteractorProtocol!
	var router: RegistrationRouterProtocol!

	init(
		view: RegistrationViewControllerProtocol,
		interactor: RegistrationInteractorProtocol,
		router: RegistrationRouterProtocol
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}

	func viewDidLoad() {
		interactor.fetchCountries()
	}

	func didTapLevelInfo() {
		router?.showLevelInfoScreen()
	}

	func didTapGetStarted(name: String, surname: String, gender: String) {
		interactor.registerUser(name: name, surname: surname, gender: gender)
	}
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {

	func didFetchCountries(_ countries: [String]) {
		self.countries = countries
		view?.updateCountries(countries)
	}

	func registrationDidSucceed() {
		router.navigateToNextScreen()
	}

	func registrationDidFail(error: Error) {

	}
}
*/
