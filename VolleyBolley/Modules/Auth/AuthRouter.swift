//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import Swinject
import UIKit

final class AuthRouter: AuthRouterProtocol {

    weak var viewController: UIViewController?
    weak var router: AppRouter?

    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.router = coordinator
    }

    func showPhoneAuth() {
        router?.pushPhoneAuth()
    }

    func showUserRegScreen() {
        router?.pushRegistrationScreen()
    }
}
