//
//  HomeAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class HomeAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(HomeViewController.self) { _ in
            let interactor = HomeInteractor()
            let router = HomeRouter()
            let presenter = HomePresenter(interactor: interactor, router: router)
            let view = HomeViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
