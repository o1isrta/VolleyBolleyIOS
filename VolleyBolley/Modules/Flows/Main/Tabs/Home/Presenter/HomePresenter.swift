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
        router.showMap(for: .courts)
    }

    func didTapFindGame() {
        router.showMap(for: .games)
    }

    func didTapCreateTourney() {
        router.showMap(for: .tournaments)
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
                title: courtWithWeather.court.name,
                location: courtWithWeather.court.address
            )
            let weatherViewModel = WeatherViewModel(weather: courtWithWeather.weather)

            view?.displayCreateNewGameButton(
                state: .withCourtAndWeather(court: courtSummaryViewModel, weather: weatherViewModel)
            )
        } catch let error as LocationError {
            print("⚠️ Location error: \(error)")
            view?.displayCreateNewGameButton(state: .locationRestricted)
        } catch {
            print("⚠️ Unknown error: \(error)")
        }
    }

    private func loadNearbyGamesCount() {
        let nearbyGamesCount = interactor.loadTotalCountOfUpcomingGamesAndTournaments()
        view?.displayFindGameButton(gamesCount: nearbyGamesCount)
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {}
