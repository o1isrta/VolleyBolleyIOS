//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadNearestCourtWithWeather() -> NearestCourtWithWeather
    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int
}

final class HomeInteractor: HomeInteractorProtocol {

    func loadNearestCourtWithWeather() -> NearestCourtWithWeather {
        // TODO: - remove mock data
        let nearestCourt = CourtModel(
            id: 1,
            price: "",
            description: "",
            contacts: [],
            imageUrl: nil,
            tagList: [],
            location: LocationModel(
                latitude: 0,
                longitude: 0,
                courtName: "Karon Beach Club",
                locationName: "Patak Rd, Mueang Phuket"
            )
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
