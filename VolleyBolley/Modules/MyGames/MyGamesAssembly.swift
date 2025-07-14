//
//  MyGamesAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class MyGamesAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(MyGamesViewController.self) { _ in
            let interactor = MyGamesInteractor()
            let router = MyGamesRouter(viewController: nil)
            let presenter = MyGamesPresenter(interactor: interactor, router: router)
            let view = MyGamesViewController(presenter: presenter)

            presenter.view = view
            router.viewController = view

            return view
        }
    }
}
