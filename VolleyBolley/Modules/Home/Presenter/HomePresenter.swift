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
        router: HomeRouterProtocol
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
        await loadCourtAndWeather()
        loadNearbyGamesCount()
    }

    private func loadCourtAndWeather() async {
        do {
            let courtWithWeather = try await interactor.loadNearestCourtWithWeather()

            let courtSummaryViewModel = LocationTitleViewModel(
                title: courtWithWeather.court?.name ?? "",
                location: courtWithWeather.court?.address ?? ""
            )

            if let weather = courtWithWeather.weather {
                let weatherVM = WeatherViewModel(weather: weather)
                view?.displayCreateNewGameButton(
                    state: .withLocationAndWeather(location: courtSummaryViewModel, weather: weatherVM)
                )
            } else {
                view?.displayCreateNewGameButton(
                    state: .withLocationOnly(location: courtSummaryViewModel)
                )
            }
        } catch {
            print(error.localizedDescription)
            view?.displayCreateNewGameButton(state: .locationRestricted)
        }
    }

    private func loadNearbyGamesCount() {
        let nearbyGamesCount = interactor.loadTotalCountOfUpcomingGamesAndTournaments()
        view?.displayFindGameButton(gamesCount: nearbyGamesCount)
    }
}
