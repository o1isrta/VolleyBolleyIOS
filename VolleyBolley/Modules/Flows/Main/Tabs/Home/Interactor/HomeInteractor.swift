//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather
    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let locationRepository: LocationRepositoryProtocol

    // MARK: - Initializers

    init(
        locationRepository: LocationRepositoryProtocol
    ) {
        self.locationRepository = locationRepository
    }

    func loadNearestCourtWithWeather() async throws -> NearestCourtWithWeather {
        // TODO: - remove mock data
        let playerLocation = try await locationRepository.getPlayerLocation(forceUpdate: false, timeout: 10)
        print("✅ Player location: \(playerLocation)")

        let nearestCourt = Court(
            id: 1,
            name: "Karon Beach Club",
            details: "",
            address: "Patak Rd, Mueang Phuket",
            coordinates: Coordinates(latitude: 8.0000, longitude: 98.0000),
            pricingInfo: "",
            photoURL: nil,
            tags: [],
            contacts: []
        )

        let weather = AppWeather(temperature: 26.0, condition: .partlyCloudy)

        let nearestCourtWithWeather = NearestCourtWithWeather(court: nearestCourt, weather: weather)

        return nearestCourtWithWeather
    }

    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int {
        // TODO: - remove mock data
        12
    }
}
