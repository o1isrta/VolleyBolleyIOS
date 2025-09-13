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
        print("HomePresenter - Create New Game")
    }

    func didTapFindGame() {
        print("HomePresenter - Find Game")
    }

    func didTapCreateTourney() {
        print("HomePresenter - Create Tourney")
    }

    func didTapDonate() {
        print("HomePresenter - Donate")
    }

    private func loadInitialData() async {
        await loadPlayer()
        await loadCourtAndWeather()
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
                title: courtWithWeather.court.name,
                location: courtWithWeather.court.address
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
            view?.displayCreateNewGameButton(state: .basic)
        }
    }
}
