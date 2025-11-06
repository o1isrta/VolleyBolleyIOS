//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeRouterProtocol.self) { resolver in
            HomeRouter(
                viewControllerFactory: {
                    resolver.safeResolve(HomeViewProtocol.self)
                },
                mapFactory: { contentType in
                    guard let mapView = resolver.resolve(MapViewProtocol.self, argument: contentType) else {
                        fatalError("Couldn't resolve MapViewProtocol")
                    }

                    return mapView
                }
            )
        }
        .inObjectScope(.container)

        container.register(HomeViewProtocol.self) { resolver in
            MainActor.assumeIsolated {

                let router = resolver.resolve(HomeRouterProtocol.self)!
                let interactor = HomeInteractor(
                    locationRepository: resolver.resolve(LocationRepositoryProtocol.self)!
                )
                let presenter = HomePresenter(
                    interactor: interactor,
                    router: router
                )
                let view = HomeViewController(presenter: presenter)

                interactor.presenter = presenter
                presenter.view = view

                return view
            }
        }
    }
}
