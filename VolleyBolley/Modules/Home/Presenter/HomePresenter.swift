//
//  HomePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapCreateNewGame()
    func didTapFindGame()
    func didTapCreateTourney()
    func didTapDonate()
}

final class HomePresenter: HomePresenterProtocol {

    // MARK: - Public Properties

    weak var view: HomeViewProtocol?

    // MARK: - Private Properties

    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    // MARK: - Initializers

    init(
        interactor: HomeInteractorProtocol,
        router: HomeRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        loadInitialData()
    }

    func didTapCreateNewGame() {
        router.showMapForCreateNewGame()
    }

    func didTapFindGame() {
        router.showMapForFindGame()
    }

    func didTapCreateTourney() {
        router.showMapForCreateTourney()
    }

    func didTapDonate() {
        router.showDonate()
    }

    // MARK: - Private Methods

    private func loadInitialData() {
        loadPlayer()
        loadCourtAndWeather()
        loadNearbyGamesCount()
    }

    private func loadPlayer() {
        Task { @MainActor in
            let (player, avatarImage) = await interactor.loadPlayerData()
            let navBarVM = NavBarViewModel(player: player, avatarImage: avatarImage)
            view?.displayNavBar(viewModel: navBarVM)
        }
    }

    private func loadCourtAndWeather() {
        let courtWithWeather = interactor.loadNearestCourtWithWeather()
        let locationVM = LocationTitleViewModel(
            title: courtWithWeather.court.location.courtName,
            location: courtWithWeather.court.location.locationName
        )

        if let weather = courtWithWeather.weather {
            let weatherVM = WeatherViewModel(weather: weather)
            view?.displayCreateNewGameButton(
                state: .withLocationAndWeather(location: locationVM, weather: weatherVM)
            )
        } else {
            view?.displayCreateNewGameButton(
                state: .withLocationOnly(location: locationVM)
            )
        }
    }

    private func loadNearbyGamesCount() {
        let nearbyGamesCount = interactor.loadTotalCountOfUpcomingGamesAndTournaments()
        view?.displayFindGameButton(gamesCount: nearbyGamesCount)
    }
}
