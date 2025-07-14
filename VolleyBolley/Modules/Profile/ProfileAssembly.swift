//
//  ProfileAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class ProfileAssembly: Assembly {

    // MARK: - Public Methods

    func assemble(container: Container) {
        container.register(ProfileViewController.self) { _ in
            let interactor = ProfileInteractor()
            let router = ProfileRouter(viewController: nil)
            let presenter = ProfilePresenter(interactor: interactor, router: router)
            let view = ProfileViewController(presenter: presenter)

            presenter.view = view
            router.viewController = view

            return view
        }
    }
}
