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
            let vc = PhoneAuthViewController()
            let interactor = PhoneAuthInteractor()
            let appRouter = resolver.resolve(AppRouter.self)

            let router = PhoneAuthRouter(
                viewController: vc,
                resolver: resolver,
                coordinator: appRouter
            )

            let presenter = PhoneAuthPresenter(
                view: vc,
                interactor: interactor,
                router: router
            )

            interactor.presenter = presenter
            vc.presenter = presenter
            return vc
        }.inObjectScope(.transient)

        container.register(PhoneAuthInteractorProtocol.self) { _ in
            PhoneAuthInteractor()
        }
    }
}
