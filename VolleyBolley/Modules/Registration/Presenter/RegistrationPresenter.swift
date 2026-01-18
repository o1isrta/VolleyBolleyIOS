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

	func viewDidLoad()
	func nextButtonTapped()
	func getICellsCount() -> Int
	func getCellType(index: Int) -> RegistrationCellType
	func getPlayerNameViewModel(type: RegistrationNameCellType) -> RegistrationPlayerNameCellViewModel
	func getPlayerLevelViewModel() -> RegistrationPlayerLevelCellViewModel
	func getPlayerGenderViewModel() -> RegistrationPlayerGenderCellViewModel
	func getPlayerBirthdayViewModel() -> RegistrationPlayerBirthdayCellViewModel
	func getPlayerLocationViewModel(type: RegistrationLocationType) -> RegistrationPlayerLocationCellViewModel
}

final class RegistrationPresenter: RegistrationPresenterProtocol {

	// MARK: - Public Properties

	weak var view: RegistrationViewControllerProtocol?
	let interactor: RegistrationInteractorProtocol
	let router: RegistrationRouterProtocol

	// MARK: - Private Properties

	private var countries: [String] = []
	private var cities: [String] = []

	private var name: String = ""
	private var surname: String = ""
	private var gender: RegistrationGenderType?
	private var birthday: String = ""
	private var playerLevel: PlayerLevel?
	private var country: String = ""
	private var city: String = ""

	private enum Constants {
		static let birthdayLength: Int = 14
	}

	// MARK: - Initializers

	init(
		view: RegistrationViewControllerProtocol,
		interactor: RegistrationInteractorProtocol,
		router: RegistrationRouterProtocol
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		// TODO: - сделать получение данных с сервера
//		interactor.fetchCountries()
	}

	func nextButtonTapped() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		// TODO: - тут нужно собрать модель и отправить данные на сервер
		print("router.nextButtonTapped()")
		print("name", name)
		print("surname", surname)
		print("birthday", birthday)
		print("gender", gender)
		print("playerLevel", playerLevel)
		print("country", country)
		print("city", city)
//		interactor.registerUser(name: name, surname: surname, gender: gender)
	}

	func getICellsCount() -> Int {
		RegistrationCellType.allCases.count
	}

	func getCellType(index: Int) -> RegistrationCellType {
		RegistrationCellType.allCases[index]
	}

	func getPlayerNameViewModel(type: RegistrationNameCellType) -> RegistrationPlayerNameCellViewModel {
		RegistrationPlayerNameCellViewModel(type: type) { value in
			switch type {
			case .name:
				self.setupName(to: value)
			case .surname:
				self.setupSurname(to: value)
			}
		}
	}

	func getPlayerGenderViewModel() -> RegistrationPlayerGenderCellViewModel {
		RegistrationPlayerGenderCellViewModel { gender in
			print("gender", gender)
			self.setupGender(to: gender)
		}
	}

	func getPlayerBirthdayViewModel() -> RegistrationPlayerBirthdayCellViewModel {
		RegistrationPlayerBirthdayCellViewModel { date in
			self.setupBirthday(to: date)
		}
	}

	func getPlayerLevelViewModel() -> RegistrationPlayerLevelCellViewModel {
		RegistrationPlayerLevelCellViewModel {
		   self.didTapLevelInfo()
		} callback: { level in
			self.setupPlayerLevel(to: level)
		}
	}

	func getPlayerLocationViewModel(type: RegistrationLocationType) ->
	RegistrationPlayerLocationCellViewModel {
		let model = RegistrationPlayerLocationCellViewModel(
			type: .city,
			items: getLocation(type: type)
		) { value in
			self.setupLocation(type: type, to: value)
		}
		return model
	}
}

// MARK: - Private Methods

private extension RegistrationPresenter {

	func setupName(to name: String) {
		self.name = name
		validateData()
	}

	func setupSurname(to surname: String) {
		self.surname = surname
		validateData()
	}

	func setupGender(to gender: RegistrationGenderType) {
		self.gender = gender
		validateData()
	}

	func setupBirthday(to date: String) {
		self.birthday = date
		validateData()
	}

	func didTapLevelInfo() {
		router.showLevelInfoScreen()
	}

	func setupPlayerLevel(to playerLevel: PlayerLevel) {
		self.playerLevel = playerLevel
		validateData()
	}

	func setupLocation(type: RegistrationLocationType, to value: String) {
		switch type {
		case .country:
			country = value
			// TODO: - сделать получение данных с сервера
//			cities = interactor.fetchCities()
			cities = ["Koh Phangan", "Koh Samui"]
			view?.reloadTableView()
		case .city:
			city = value
		}
		validateData()
	}

	// TODO: - сделать получение данных с сервера
	func getLocation(type: RegistrationLocationType) -> [String] {
		switch type {
		case .country:
			countries = ["Cyprus", "Thailand"]
			return countries
		case .city:
			return cities
		}
	}

	func validateData() {
		guard checkData() else {
			view?.allowNextStep(false)
			return
		}
		view?.allowNextStep(true)
	}

	func checkData() -> Bool {
		guard
			birthday.count == Constants.birthdayLength,
			!name.isEmpty,
			!surname.isEmpty,
			playerLevel != nil,
			!country.isEmpty,
			!city.isEmpty
		else {
			return false
		}

		return true
	}
}

extension RegistrationPresenter: RegistrationInteractorOutputProtocol {

	func didFetchCountries(_ countries: [String]) {
		self.countries = countries
//		view?.updateCountries(countries)
	}

	func registrationDidSucceed() {
		router.navigateToNextScreen()
	}

	func registrationDidFail(error: Error) {

	}
}
