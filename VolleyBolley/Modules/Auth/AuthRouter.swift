//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import UIKit
import Swinject

final class AuthRouter: AuthRouterProtocol {
    
    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?
    
    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }
    
    func showPhoneAuth() {
        coordinator?.pushPhoneAuth()
    }
    
    func showUserRegScreen() {
        coordinator?.pushUserReg()
    }
}
