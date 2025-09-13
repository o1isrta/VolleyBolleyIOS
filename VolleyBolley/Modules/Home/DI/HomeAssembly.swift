//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NearestCourtWithWeatherUseCaseProtocol.self) { resolver in
            guard
                let locationRepository = resolver.resolve(LocationRepositoryProtocol.self),
                let courtsRepository = resolver.resolve(CourtsRepositoryProtocol.self),
                let weatherRepository = resolver.resolve(WeatherRepositoryProtocol.self)
            else {
                fatalError("Error: Failed to register NearestCourtWithWeatherUseCase")
            }

            let useCase = NearestCourtWithWeatherUseCase(
                locationRepository: locationRepository,
                courtRepository: courtsRepository,
                weatherRepository: weatherRepository
            )

            return useCase
        }

        container.register(HomeViewController.self) { resolver in
            MainActor.assumeIsolated {
                guard
                    let playersRepository = resolver.resolve(PlayersRepositoryProtocol.self),
                    let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self),
                    let nearestCourtWithWeatherUseCase = resolver.resolve(NearestCourtWithWeatherUseCaseProtocol.self)
                else {
                    fatalError("Error: Failed to register HomeViewController")
                }

                let router = HomeRouter()

                let interactor = HomeInteractor(
                    playersRepository: playersRepository,
                    imageLoader: imageLoader,
                    nearestCourtWithWeatherUseCase: nearestCourtWithWeatherUseCase
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
