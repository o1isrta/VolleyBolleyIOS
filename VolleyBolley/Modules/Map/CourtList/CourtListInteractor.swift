//
//  CourtListInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 08.07.2025.
//

import CoreLocation
import Foundation

protocol CourtListInteractorProtocol: AnyObject {
    func fetchCourtsWithDistance(userLocation: CLLocation?, completion: @escaping ([(court: CourtModel, distance: Double)]) -> Void)
    func calculateDistancesForCourts(_ courts: [CourtModel], userLocation: CLLocation?, completion: @escaping ([(court: CourtModel, distance: Double)]) -> Void)
}

class CourtListInteractor: CourtListInteractorProtocol {

    // MARK: - Private Properties

    private let distanceService: DistanceServiceProtocol
    private let courts: [CourtModel]

    // MARK: - Initializers

    init(courts: [CourtModel], distanceService: DistanceServiceProtocol = DistanceService()) {
        self.distanceService = distanceService
        self.courts = courts
    }

    func fetchCourtsWithDistance(userLocation: CLLocation?, completion: @escaping ([(court: CourtModel, distance: Double)]) -> Void) {
        calculateDistancesForCourts(courts, userLocation: userLocation, completion: completion)
    }

    func calculateDistancesForCourts(_ courts: [CourtModel], userLocation: CLLocation?, completion: @escaping ([(court: CourtModel, distance: Double)]) -> Void) {
        var courtsWithDistance: [(CourtModel, Double)]
        if let userLocation = userLocation {
            courtsWithDistance = distanceService.calculateDistances(from: userLocation, to: courts)
        } else {
            courtsWithDistance = courts.map { ($0, -1) }
        }

        // Sort by distance (closest first)
        courtsWithDistance.sort { $0.1 < $1.1 }
        completion(courtsWithDistance)
    }
}
