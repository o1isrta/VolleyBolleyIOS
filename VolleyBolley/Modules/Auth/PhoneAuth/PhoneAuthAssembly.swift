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

        container.register(PhoneAuthInteractorProtocol.self) { _ in
            PhoneAuthInteractor()
        }

        container.register(PhoneAuthRouterProtocol.self) { (resolver, viewController: UIViewController) in
            let coordinator = resolver.resolve(AppRouter.self)!
            return PhoneAuthRouter(viewController: viewController, coordinator: coordinator, resolver: resolver)
        }

        container.register(PhoneAuthViewController.self) { resolver in
            let phoneRegVC = PhoneAuthViewController()

            guard let interactor = resolver.resolve(PhoneAuthInteractorProtocol.self) else {
                fatalError("PhoneAuthInteractor не зарегистрирован")
            }

            guard let router = resolver.resolve(PhoneAuthRouterProtocol.self, argument: phoneRegVC as UIViewController) else {
                fatalError("PhoneAuthRouter не зарегистрирован")
            }

            let presenter = PhoneAuthPresenter(view: phoneRegVC, interactor: interactor, router: router)

            phoneRegVC.presenter = presenter
            interactor.presenter = presenter

            return phoneRegVC
        }

        container.register(PhoneVerifyViewController.self) { (_, phoneNumber: String) in
            PhoneVerifyViewController(phoneNumber: phoneNumber)
        }
    }
}
