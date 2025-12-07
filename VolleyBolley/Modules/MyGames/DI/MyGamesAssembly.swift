//
//  MyGamesAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 12.10.2025.
//

import Swinject

final class MyGamesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MyGamesViewController.self) { resolver in
            let router = MyGamesRouter()
            let interactor = MyGamesInteractor()
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
