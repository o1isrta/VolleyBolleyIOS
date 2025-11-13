//
//  UserCardPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 13.11.2025.
//

import UIKit

protocol UserCardPresenterProtocol {
	var view: UserCardViewControllerProtocol? { get set }
	var interactor: UserCardInteractorProtocol? { get set }
	var router: UserCardRouterProtocol { get set }
	var latestActivity: [UserActivityModel] { get }
	func viewDidLoad()
	func backButtonTapped()
	func setAsFavorite(_ isFavorite: Bool)
	func openMap(with coordinates: Coordinates)
}

final class UserCardPresenter: UserCardPresenterProtocol {

	// MARK: - Public Properties

	weak var view: UserCardViewControllerProtocol?
	var interactor: UserCardInteractorProtocol?
	var router: UserCardRouterProtocol

	// MARK: - Private Properties

	private(set) var latestActivity: [UserActivityModel] = []

	// MARK: - Initializers

	init(
		interactor: UserCardInteractorProtocol,
		router: UserCardRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		setupUserCard()
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func setAsFavorite(_ isFavorite: Bool) {
		interactor?.setAsFavorite(isFavorite)
	}

	func openMap(with coordinates: Coordinates) {
		// TODO: - open map with coordinates
		print("open map at location:", coordinates)
	}
}

// MARK: - Private Methods

private extension UserCardPresenter {

	func setupUserCard() {
		view?.isLoadingIndicatorVisible(true)
		// TODO: - needed interactor request
//		let playerData: Player = interactor?.fetchUserData()
		let playerData: Player = Player.mockDefault
		// TODO: - temporarily gag
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
			guard let self else { return }
			self.view?.isLoadingIndicatorVisible(false)
			let userCardModel = UserCardViewModel(
				firstName: playerData.firstName,
				lastName: playerData.lastName,
				level: playerData.level
			)
			self.view?.setupUserData(with: userCardModel)

			self.setupActivity()// TODO: - set activity from interactor?.fetchUserData()
			self.setupAvatar(by: playerData.avatarURL)
		}
	}

	func setupAvatar(by url: URL?) {
		// TODO: - needed interactor request
//		guard let url else { return }
//		let avatar = interactor?.loadAvatar()
		let avatar: UIImage = .imgPerson
		view?.setupAvatar(avatar)
	}

	func setupActivity() {
		// TODO: - set activity to table
		let court = CourtModel.mockData
		let locationModel = LocationModel(
			latitude: court.location.latitude,
			longitude: court.location.longitude,
			courtName: court.location.courtName,
			locationName: court.location.locationName
		)
		let activityModel = UserActivityModel(
			dateString: AppDateFormatters.iso8601.string(from: Date()),
			location: locationModel
		)
		latestActivity = Array(repeating: activityModel, count: 3)
		view?.reloadTableView()
	}
}
