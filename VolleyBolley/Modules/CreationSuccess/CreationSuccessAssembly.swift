//
//  CreationSuccessAssembly.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import Swinject

final class CreationSuccessAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CreationSuccessViewController.self) { (_, type: CreationType) in

            let router = CreationSuccessRouter()
            let interactor = CreationSuccessInteractor()
            let presenter = CreationSuccessPresenter(
                interactor: interactor,
                router: router,
                type: type
            )
            let viewController = CreationSuccessViewController(presenter: presenter)

            router.viewController = viewController
            presenter.view = viewController

            return viewController
        }
    }
}
