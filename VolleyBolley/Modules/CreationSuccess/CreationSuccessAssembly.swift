//
//  CreationSuccessAssembly.swift
//  VolleyBolley
//
//  Created by Danil Otmakhov on 11.09.2025.
//

import Swinject

final class CreationSuccessAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CreationSuccessViewController.self) { resolver in
            guard let usersRepository = resolver.resolve(UsersRepositoryProtocol.self) else {
                fatalError("Error: Failed to register CreationSuccessViewController")
            }

            let router = CreationSuccessRouter()
            let interactor = CreationSuccessInteractor(usersRepository: usersRepository)
            let presenter = CreationSuccessPresenter(interactor: interactor, router: router)
            let viewController = CreationSuccessViewController(presenter: presenter)

            router.viewController = viewController
            presenter.view = viewController

            return viewController
        }
    }
}
