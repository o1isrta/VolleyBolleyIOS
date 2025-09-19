//
//  HomeInteractor.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeInteractorProtocol: AnyObject {
    func loadPlayerData() async -> (Player, UIImage?)
    func loadNearestCourtWithWeather() -> NearestCourtWithWeather
    func loadTotalCountOfUpcomingGamesAndTournaments() -> Int
}

final class HomeInteractor: HomeInteractorProtocol {

    // MARK: - Private Properties

    private let imageLoader: ImageLoadingServiceProtocol

    // MARK: - Initializers

    init(
        imageLoader: ImageLoadingServiceProtocol
    ) {
        self.imageLoader = imageLoader
    }

    // MARK: - Public Methods

    func loadPlayerData() async -> (Player, UIImage?) {
        let player = Player(
            firstName: "Artem",
            lastName: "",
            gender: "",
            dateOfBirth: AppDateFormatters.serverDateOnly.date(from: "1970-02-20")!,
            level: .light,
            countryID: 1,
            cityID: 1,
            avatarURL: URL(
                string: "https://raw.githubusercontent.com/xcode73/myapp-mocks/"
                      + "main/VolleyBolley/Images/Profile/profile1.jpg"
            )
        )
        var avatarImage: UIImage?

        if let avatarURL = player.avatarURL {
            do {
                avatarImage = try await imageLoader.loadImage(from: avatarURL)
            } catch {
                print("❌ Failed to load avatar:", error)
            }
        }

        return (player, avatarImage)
    }

    func loadNearestCourtWithWeather() -> NearestCourtWithWeather {
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
        12
    }
}
