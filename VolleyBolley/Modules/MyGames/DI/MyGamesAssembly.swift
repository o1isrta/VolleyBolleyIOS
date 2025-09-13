//
//  MyGamesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class MyGamesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MyGamesViewController.self) { resolver in

            guard
                let usersRepository = resolver.resolve(PlayersRepositoryProtocol.self),
                let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self)
            else {
                fatalError("Error: Failed to register MyGamesViewController")
            }

            let router = MyGamesRouter()

            let interactor = MyGamesInteractor(
                playersRepository: usersRepository,
                imageLoader: imageLoader
            )

            let presenter = MyGamesPresenter(
                interactor: interactor,
                router: router
            )

            let view = MyGamesViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
