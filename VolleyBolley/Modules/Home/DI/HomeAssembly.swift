//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeViewProtocol.self) { resolver in
            MainActor.assumeIsolated {
                guard
                    let locationRepository = resolver.resolve(LocationRepositoryProtocol.self),
                    let courtsRepository = resolver.resolve(CourtsRepositoryProtocol.self),
                    let findNearestCourtUseCase = resolver.resolve(FindNearestCourtUseCaseProtocol.self),
                    let mapFactory = resolver.resolve(MapModuleFactoryProtocol.self)
                else {
                    fatalError("Error: Failed to register HomeViewController")
                }

                let interactor = HomeInteractor(
                    locationRepository: locationRepository,
                    courtsRepository: courtsRepository,
                    findNearestCourtUseCase: findNearestCourtUseCase
                )
                let router = HomeRouter(mapFactory: mapFactory)
                let presenter = HomePresenter(interactor: interactor, router: router)
                let view = HomeViewController(presenter: presenter)

                router.attachViewController(view)
                presenter.view = view

                return view
            }
        }
    }
}
