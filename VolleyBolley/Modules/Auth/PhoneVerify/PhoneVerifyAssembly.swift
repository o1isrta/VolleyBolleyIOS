//
//  PhoneVerifyAssembly.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import Swinject

final class PhoneVerifyAssembly: Assembly {

    func assemble(container: Container) {
        container.register(PhoneVerifyViewController.self) { (resolver, phoneNumber: String) in
            let phoneVerifyVC = PhoneVerifyViewController(phoneNumber: phoneNumber)
            let interactor = PhoneVerifyInteractor()
            let appRouter = resolver.resolve(AppRouter.self)
            let router = PhoneVerifyRouter(viewController: phoneVerifyVC, coordinator: appRouter)
            let presenter = PhoneVerifyPresenter(view: phoneVerifyVC, interactor: interactor, router: router, phoneNumber: phoneNumber)

            interactor.presenter = presenter
            phoneVerifyVC.presenter = presenter
            return phoneVerifyVC
        }

        container.register(PhoneVerifyInteractorProtocol.self) { _ in
            PhoneVerifyInteractor()
        }
    }
}
