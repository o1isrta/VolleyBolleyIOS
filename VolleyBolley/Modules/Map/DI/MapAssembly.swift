//
//  MapAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.08.2025.
//

import Swinject

final class MapAssembly: Assembly {

	func assemble(container: Container) {
        container.register(CourtsWithDistanceUseCaseProtocol.self) { resolver in
            guard let distanceCalculator = resolver.resolve(DistanceCalculatorProtocol.self) else {
                fatalError("Error: Failed to register SortCourtsByDistanceUseCase")
            }

            return SortCourtsByDistanceUseCase(distanceCalculator: distanceCalculator)
        }

		container.register(MapViewController.self) { resolver in
            guard
                let networkService = resolver.resolve(NetworkServiceProtocol.self),
                let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self),
                let locationRepository = resolver.resolve(LocationRepositoryProtocol.self),
                let courtsRepository = resolver.resolve(CourtsRepositoryProtocol.self),
                let findNearestCourtUseCase = resolver.resolve(FindNearestCourtUseCaseProtocol.self),
                let courtsWithDistanceUseCase = resolver.resolve(CourtsWithDistanceUseCaseProtocol.self)
            else {
                fatalError("Error: Failed to register MapViewController")
            }

			let router = MapRouter()
			let interactor = MapInteractor(
                networkService: networkService,
                imageLoader: imageLoader,
                locationRepository: locationRepository,
                courtsRepository: courtsRepository,
                courtsWithDistanceUseCase: courtsWithDistanceUseCase,
                findNearestCourtUseCase: findNearestCourtUseCase
            )

			let presenter = MapPresenter(
				interactor: interactor,
				router: router
			)

			let view = MapViewController(presenter: presenter)
			router.attachViewController(view)
			presenter.view = view

			return view
		}

        container.register(MapModuleFactoryProtocol.self) { resolver in
            MapModuleFactory(resolver: resolver)
        }
	}
}
