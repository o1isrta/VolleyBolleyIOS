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
        coordinator?.showPhoneAuth()
    }

    func showUserRegScreen() {
        coordinator?.showUserReg()
    }
}
