//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    // MARK: - Public methods

    func assemble(container: Container) {
        registerViewController(container: container)
    }

    // MARK: - Private methods

    private func registerViewController(container: Container) {
        container.register(HomeViewController.self) { resolver in
            MainActor.assumeIsolated {
                guard
                    let playersRepository = resolver.resolve(PlayersRepositoryProtocol.self),
                    let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self),
                    let locationRepository = resolver.resolve(LocationRepositoryProtocol.self),
                    let weatherRepository = resolver.resolve(WeatherRepositoryProtocol.self),
                    let courtsUseCase = resolver.resolve(CourtsUseCaseProtocol.self),
                    let gamesUseCase = resolver.resolve(GamesUseCaseProtocol.self),
                    let mapFactory = resolver.resolve(MapModuleFactoryProtocol.self)
                else {
                    fatalError("Error: Failed to register HomeViewController")
                }

                let router = HomeRouter(mapFactory: mapFactory)

                let interactor = HomeInteractor(
                    playersRepository: playersRepository,
                    imageLoader: imageLoader,
                    locationRepository: locationRepository,
                    weatherRepository: weatherRepository,
                    courtsUseCase: courtsUseCase,
                    gamesUseCase: gamesUseCase
                )

                let presenter = HomePresenter(
                    interactor: interactor,
                    router: router
                )

                let view = HomeViewController(presenter: presenter)
                router.attachViewController(view)
                presenter.view = view

                return view
            }
        }
    }
}
