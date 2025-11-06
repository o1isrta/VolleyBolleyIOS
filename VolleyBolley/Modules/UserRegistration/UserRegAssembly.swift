//
//  UserRegAssembly.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//

import Swinject

final class UserRegAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UserRegRouterProtocol.self) { resolver in
            UserRegRouter(
                viewControllerFactory: {
                    resolver.safeResolve(UserRegViewProtocol.self)
                }
            )
        }
        .inObjectScope(.container)

        container.register(UserRegViewProtocol.self) { resolver in
            let router = resolver.resolve(UserRegRouterProtocol.self)!
            let interactor = UserRegInteractor()
            let presenter = UserRegPresenter(
                interactor: interactor,
                router: router,
                finishRegistrationFlow: { [weak router] in
                    router?.finishRegistration()
                }
            )
            let view = UserRegViewController(presenter: presenter)

            interactor.presenter = presenter
            presenter.view = view

            return view
        }
    }
}
