//
//  UserRegAssembly.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//
import Swinject

final class UserRegAssembly: Assembly {

    func assemble(container: Container) {
        container.register(UserRegViewController.self) { resolver in
            let userRegVC = UserRegViewController()

            let interactor = resolver.resolve(UserRegInteractorProtocol.self)!
            let appRouter = resolver.resolve(AppRouter.self)! // resolve вместо self.coordinator
            let router = UserRegRouter(viewController: userRegVC, coordinator: appRouter)
            let presenter = UserRegPresenter(view: userRegVC, interactor: interactor, router: router)

            userRegVC.presenter = presenter
            return userRegVC
        }

        container.register(UserRegInteractorProtocol.self) { _ in
            UserRegInteractor()
        }
    }
}
