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
                let usersRepository = resolver.resolve(UsersRepositoryProtocol.self),
                let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self)
            else {
                fatalError("Error: Failed to register HomeViewController")
            }

            let router = HomeRouter()

            let interactor = HomeInteractor(
                usersRepository: usersRepository,
                imageLoader: imageLoader
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
