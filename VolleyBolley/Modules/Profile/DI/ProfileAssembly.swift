//
//  ProfileAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class ProfileAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProfileViewController.self) { resolver in
            let appRouter = resolver.resolve(AppRouter.self)

            guard
                let usersRepository = resolver.resolve(UsersRepositoryProtocol.self),
                let imageLoader = resolver.resolve(ImageLoadingServiceProtocol.self)
            else {
                fatalError("Error: Failed to register ProfileViewController")
            }

            let router = ProfileRouter(router: appRouter)

            let interactor = ProfileInteractor(
                usersRepository: usersRepository,
                imageLoader: imageLoader
            )

            let presenter = ProfilePresenter(
                interactor: interactor,
                router: router
            )

            let view = ProfileViewController(presenter: presenter)

            router.attachViewController(view)
            presenter.view = view

            return view
        }
    }
}
