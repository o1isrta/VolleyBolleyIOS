//
//  CourtListInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol CourtListInteractorProtocol: AnyObject {
	func fetchCourtsWithDistance(
		userLocation: CLLocation?,
		completion: @escaping ([(court: Court, distance: Double)]) -> Void
	)
	func calculateDistancesForCourts(
		_ courts: [Court],
		userLocation: CLLocation?,
		completion: @escaping ([(court: Court, distance: Double)]) -> Void
	)
}

final class CourtListInteractor: CourtListInteractorProtocol {

	// MARK: - Private Properties

	private let distanceService: DistanceCalculatorProtocol
	private let courts: [Court]

	// MARK: - Initializers

    init(
        courts: [Court],
        distanceService: DistanceCalculatorProtocol
    ) {
		self.distanceService = distanceService
		self.courts = courts
	}

	// MARK: - Public Methods

	func fetchCourtsWithDistance(
		userLocation: CLLocation?,
		completion: @escaping ([(court: Court, distance: Double)]) -> Void
	) {
		calculateDistancesForCourts(courts, userLocation: userLocation, completion: completion)
	}

    // TODO: - refactor
	func calculateDistancesForCourts(
		_ courts: [Court],
		userLocation: CLLocation?,
		completion: @escaping ([(court: Court, distance: Double)]) -> Void
	) {
		var courtsWithDistance: [(Court, Double)]
		if let userLocation = userLocation {
//			courtsWithDistance = distanceService.calculateDistances(from: userLocation, to: courts)
            courtsWithDistance = []
		} else {
			courtsWithDistance = courts.map { ($0, -1) }
		}
		// Sort by distance (closest first)
//		courtsWithDistance.sort { $0.1 < $1.1 }
		completion(courtsWithDistance)
	}
}
