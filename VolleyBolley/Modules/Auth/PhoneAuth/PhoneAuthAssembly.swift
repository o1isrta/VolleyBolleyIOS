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

        // MARK: - Interactor
        container.register(PhoneAuthInteractorProtocol.self) { _ in
            PhoneAuthInteractor()
        }

        // MARK: - Router
        container.register(PhoneAuthRouterProtocol.self) { (resolver, viewController: UIViewController) in
            PhoneAuthRouter(viewController: viewController, resolver: resolver)
        }

        // MARK: - ViewController + Presenter
        container.register(PhoneAuthViewController.self) { resolver in
            let vc = PhoneAuthViewController()

            // Interactor
            guard let interactor = resolver.resolve(PhoneAuthInteractorProtocol.self) else {
                fatalError("PhoneAuthInteractor не зарегистрирован")
            }

            // Router (с безопасным resolve)
            guard let router = resolver.resolve(PhoneAuthRouterProtocol.self, argument: vc as UIViewController) else {
                fatalError("PhoneAuthRouter не зарегистрирован")
            }

            // Presenter
            let presenter = PhoneAuthPresenter(view: vc, interactor: interactor, router: router)

            // Связываем VIPER
            vc.presenter = presenter
            interactor.presenter = presenter

            return vc
        }

        // MARK: - PhoneVerifyViewController с DI и аргументом
        container.register(PhoneVerifyViewController.self) { (_, phoneNumber: String) in
            PhoneVerifyViewController(phoneNumber: phoneNumber)
        }
    }
}
