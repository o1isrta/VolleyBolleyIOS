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
    private let resolver: Resolver
    private let window: UIWindow?

    init(viewController: UIViewController, resolver: Resolver, window: UIWindow? = nil) {
        self.viewController = viewController
        self.resolver = resolver
        self.window = window
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func navigateToVerification(with phoneNumber: String) {
        guard !phoneNumber.isEmpty else { return }

        guard let phoneVerifyVC = resolver.resolve(PhoneVerifyViewController.self, argument: phoneNumber) else {
            fatalError("PhoneVerifyViewController не зарегистрирован в DI")
        }

        if let navController = viewController?.navigationController {
            navController.pushViewController(phoneVerifyVC, animated: true)
        } else if let window = window {
            let nav = UINavigationController(rootViewController: phoneVerifyVC)
            UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve, .allowUserInteraction]) {
                window.rootViewController = nav
            }
            window.makeKeyAndVisible()
        } else {
            viewController?.present(phoneVerifyVC, animated: true)
        }
    }
}
