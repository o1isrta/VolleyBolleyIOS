//
//  PhoneVerifyAssembly.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import Swinject
import UIKit

final class PhoneVerifyAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhoneVerifyViewController.self) { (resolver, phoneNumber: String) in
            let phoneVerifyVC = PhoneVerifyViewController(phoneNumber: phoneNumber)
            let interactor = PhoneVerifyInteractor()

            guard let appRouter = resolver.resolve(AppRouter.self) else {
                fatalError("AppRouter не зарегистрирован")
            }

            let router = PhoneVerifyRouter(
                viewController: phoneVerifyVC,
                coordinator: appRouter
            )

            let presenter = PhoneVerifyPresenter(
                view: phoneVerifyVC,
                interactor: interactor,
                router: router,
                phoneNumber: phoneNumber
            )

            interactor.presenter = presenter
            phoneVerifyVC.presenter = presenter
            print("🔍 VC retain count after creation: \(CFGetRetainCount(phoneVerifyVC))")
            return phoneVerifyVC
        }.inObjectScope(.transient)

        container.register(PhoneVerifyInteractorProtocol.self) { _ in
            PhoneVerifyInteractor()
        }
    }
}
