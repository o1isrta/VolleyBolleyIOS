//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import UIKit

final class AuthRouter: AuthRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?

    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }

        func showPhoneAuth() {
//            let phoneAuthVC = PhoneRegRouter.assembleModule()
//            viewController?.navigationController?.pushViewController(phoneAuthVC, animated: true)
        }

        func showUserRegScreen() {
//            let userRegVC = UserRegRouter.assembleModule()
//            viewController?.navigationController?.pushViewController(userRegVC, animated: true)
        }
}
