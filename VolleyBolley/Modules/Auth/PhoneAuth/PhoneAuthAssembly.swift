//
//  PhoneRegAssembly.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Swinject
import UIKit

final class PhoneAuthAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhoneAuthViewController.self) { resolver in
            let phoneAuthVC = PhoneAuthViewController()
            let interactor = PhoneAuthInteractor()
            let appRouter = resolver.resolve(AppRouter.self)

            let router = PhoneAuthRouter(
                viewController: phoneAuthVC,
                resolver: resolver,
                coordinator: appRouter
            )

            let presenter = PhoneAuthPresenter(
                view: phoneAuthVC,
                interactor: interactor,
                router: router
            )

            interactor.presenter = presenter
            phoneAuthVC.presenter = presenter
            return phoneAuthVC
        }.inObjectScope(.transient)

        container.register(PhoneAuthInteractorProtocol.self) { _ in
            PhoneAuthInteractor()
        }
    }
}
