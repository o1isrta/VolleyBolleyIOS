//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeViewController.self) { resolver in
            guard
                let mapFactory = resolver.resolve(MapModuleFactoryProtocol.self)
            else {
                fatalError("Error: Failed to register HomeViewController")
            }

            let router = HomeRouter(mapFactory: mapFactory)
            let interactor = HomeInteractor()

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
