//
//  MapPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol MapPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBackButton()
}

final class MapPresenter: MapPresenterProtocol {

	// MARK: - Public Properties

	weak var view: MapViewProtocol?

    // MARK: - Private Properties

    private let interactor: MapInteractorProtocol
    private let router: MapRouterProtocol

	// MARK: - Initializers

	init(
		interactor: MapInteractorProtocol,
		router: MapRouterProtocol
	) {
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

    func viewDidLoad() {
        Task { [weak self] in
            await self?.loadInitialData()
        }
    }

    func didTapBackButton() {
        router.goBackToHome()
    }

    // MARK: - Private Methods

    private func loadInitialData() async {
        await loadCourtsSortedByDistance()
        await loadNearestCourt()
    }

    private func loadCourtsSortedByDistance() async {
        do {
            let courtsWithDistance = try await interactor.loadCourtsWithDistance()
            view?.displayCourts(courts: courtsWithDistance)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadNearestCourt() async {
        do {
            let nearestCourt = try await interactor.loadNearestCourt()
            view?.displayNearestCourt(court: nearestCourt)
        } catch {
            print(error.localizedDescription)
        }
    }
}
