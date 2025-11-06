//
//  ProfileAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject

final class ProfileAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ProfileRouterProtocol.self) { resolver in
            ProfileRouter(
                viewControllerFactory: {
                    resolver.safeResolve(ProfileViewProtocol.self)
                },
                personalDataFactory: {
                    resolver.safeResolve(PersonalDataViewProtocol.self)
                },
                supportFactory: {
                    resolver.safeResolve(SupportViewProtocol.self)
                },
                faqFactory: {
                    resolver.safeResolve(FAQViewProtocol.self)
                },
                aboutFactory: {
                    resolver.safeResolve(AboutViewProtocol.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(ProfileViewProtocol.self) { resolver in
            let router = resolver.resolve(ProfileRouterProtocol.self)!
            let interactor = ProfileInteractor(
                imageLoader: resolver.resolve(ImageLoadingServiceProtocol.self)!
            )
            let presenter = ProfilePresenter(
                interactor: interactor,
                router: router
            )
            let view = ProfileViewController(presenter: presenter)

            presenter.view = view

            return view
        }
    }
}
