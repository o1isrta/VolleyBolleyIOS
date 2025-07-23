//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

class OnboardingRouter: OnboardingRouterProtocol {
    
    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?
    
    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }
    
    func navigateToAuthorizationScreen() {
//        coordinator?.showAuthorization()
    }
}
