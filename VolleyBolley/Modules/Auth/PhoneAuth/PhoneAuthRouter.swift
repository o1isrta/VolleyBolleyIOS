//
//  PhoneRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Swinject
import UIKit

final class PhoneAuthRouter: PhoneAuthRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?
    private let resolver: Resolver

    init(viewController: UIViewController, coordinator: AppRouter?, resolver: Resolver) {
        self.viewController = viewController
        self.coordinator = coordinator
        self.resolver = resolver
    }

    func navigateBack() {
        coordinator?.start()
    }

    func navigateToVerification(with phoneNumber: String) {
        guard !phoneNumber.isEmpty else { return }

        guard let phoneVerifyVC = resolver.resolve(PhoneVerifyViewController.self, argument: phoneNumber) else {
            fatalError("PhoneVerifyViewController не зарегистрирован в DI")
        }

        print("PhoneVerifyViewController frame: \(phoneVerifyVC.view.frame)")
        print("PhoneVerifyViewController background: \(phoneVerifyVC.view.backgroundColor)")
        print("PhoneVerifyViewController subviews: \(phoneVerifyVC.view.subviews)")

        // Принудительно установите background для теста
        phoneVerifyVC.view.backgroundColor = .red // Яркий цвет для теста

        performNavigation(to: phoneVerifyVC)
    }

    private func performNavigation(to viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            print("Navigation controller: \(String(describing: self.viewController?.navigationController))")
            print("Is navigation controller nil? \(self.viewController?.navigationController == nil)")

            if let navController = self.viewController?.navigationController {
                print("Navigation controller view controllers: \(navController.viewControllers)")
                print("About to push view controller")
                navController.pushViewController(viewController, animated: true)
                print("Push completed")
            } else {
                print("No navigation controller - presenting modally")
                let navController = UINavigationController(rootViewController: viewController)
                navController.modalPresentationStyle = .fullScreen
                self.viewController?.present(navController, animated: true) {
                    print("Modal presentation completed")
                }
            }
        }
    }
}
