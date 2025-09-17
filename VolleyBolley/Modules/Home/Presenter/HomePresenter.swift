//
//  HomePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

@MainActor
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapCreateNewGame()
    func didTapFindGame()
    func didTapCreateTourney()
    func didTapDonate()
}

@MainActor
final class HomePresenter: HomePresenterProtocol {

    // MARK: - Public Properties

    weak var view: HomeViewProtocol?

    // MARK: - Private Properties

    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    // MARK: - Initializers

    init(
        interactor: HomeInteractorProtocol,
        router: HomeRouterProtocol,
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

    private func loadInitialData() async {
        await loadPlayer()
        await loadCourtAndWeather()
        await loadNearbyGamesCount()
    }

    private func loadPlayer() async {
        do {
            let (player, avatarImage) = try await interactor.loadPlayerData()
            let navBarVM = NavBarViewModel(player: player, avatarImage: avatarImage)
            view?.displayNavBar(viewModel: navBarVM)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadCourtAndWeather() async {
        do {
            let courtWithWeather = try await interactor.loadNearestCourtWithWeather()
            let locationVM = LocationTitleViewModel(
                title: courtWithWeather.court.location.name,
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
        } catch {
            print(error.localizedDescription)
            view?.displayCreateNewGameButton(state: .locationRestricted)
        }
    }

    private func loadNearbyGamesCount() async {
        do {
            let nearbyGamesCount = try await interactor.loadTotalCountOfUpcomingGamesAndTournaments()
            view?.displayFindGameButton(gamesCount: nearbyGamesCount)
        } catch {
            print(error.localizedDescription)
        }
    }
}
