//
//  MyGamesAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import Swinject

final class MyGamesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MyGamesRouterProtocol.self) { resolver in
            MyGamesRouter(
                viewControllerFactory: {
                    resolver.safeResolve(MyGamesViewProtocol.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(MyGamesViewProtocol.self) { resolver in
            let router = resolver.resolve(MyGamesRouterProtocol.self)!
            let interactor = MyGamesInteractor()
            let presenter = MyGamesPresenter(
                interactor: interactor,
                router: router
            )
            let view = MyGamesViewController(presenter: presenter)

            presenter.view = view

            return view
        }
    }
}
