//
//  AppRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

final class AppCoordinator {
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = true
    }
    
    func appStart() {
        if UserDefaults.standard.isOnboardingShown {
//            showAuthorization()
            showOnboarding() // ДО ПОЯВЛЕНИЯ ОКНА АВТОРИЗАЦИИ
        } else {
            showOnboarding()
        }
    }
    
    func showOnboarding() {
        let onboardingVC = OnboardingRouter.assembleModule(coordinator: self)
        navigationController.viewControllers = [onboardingVC]
    }
    
    func showAuthorization() {
        
    }
}
