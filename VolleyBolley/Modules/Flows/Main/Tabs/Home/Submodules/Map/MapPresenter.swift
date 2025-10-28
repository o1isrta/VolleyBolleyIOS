//
//  MapPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol MapPresenterProtocol: AnyObject {
	func viewDidLoad(userLocation: CLLocation?)
    func didTapBackButton()
	func didTapSelectCourtButton(create: GameType, court: CourtModel)
}

protocol MapViewProtocol: AnyObject {
	func showCourts(_ courts: [CourtModel], nearest: CourtModel?)
}

final class MapPresenter: MapPresenterProtocol {

	// MARK: - Public Properties

	weak var view: MapViewProtocol?
	let interactor: MapInteractorProtocol
	let router: MapRouterProtocol

	// MARK: - Initializers

	init(
		interactor: MapInteractorProtocol,
		router: MapRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad(userLocation: CLLocation?) {
		interactor.fetchCourts { [weak self] courts in
			var nearest: CourtModel?
			if let userLocation = userLocation {
				nearest = courts
					.min(
						by: {
							userLocation.distance(
								from: CLLocation(
									latitude: $0.location.latitude,
									longitude: $0.location.longitude
								)
							) < userLocation.distance(
								from: CLLocation(
									latitude: $1.location.latitude,
									longitude: $1.location.longitude
								)
							)
						})
			}
			self?.view?.showCourts(courts, nearest: nearest)
		}
	}

    func didTapBackButton() {
        router.goBackToHome()
    }

	func didTapSelectCourtButton(create: GameType, court: CourtModel) {
		router.goToCreateGameOrTourney(type: create, court: court)
    }
}
