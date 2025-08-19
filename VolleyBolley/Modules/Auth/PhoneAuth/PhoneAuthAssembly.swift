//
//  PhoneRegAssembly.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Swinject

final class PhoneAuthAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhoneAuthViewController.self) { resolver in
            let phoneRegVC = PhoneAuthViewController()

            let interactor = resolver.resolve(PhoneAuthInteractorProtocol.self)!
            let appRouter = resolver.resolve(AppRouter.self)!
            let router = PhoneAuthRouter(viewController: phoneRegVC, coordinator: appRouter)

            let presenter = PhoneAuthPresenter(
                view: phoneRegVC,
                interactor: interactor,
                router: router
            )

            phoneRegVC.presenter = presenter
            interactor.presenter = presenter

            return phoneRegVC
        }

        container.register(PhoneAuthInteractorProtocol.self) { _ in
            PhoneAuthInteractor()
        }
    }
}
