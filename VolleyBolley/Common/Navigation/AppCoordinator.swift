import UIKit

final class AppCoordinator {
    let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.isNavigationBarHidden = true
    }
    
    func appStart() {
        if UserDefaults.standard.isOnboardingShown {
            showAuthorization()
        } else {
            showOnboarding()
        }
    }
    
    func showOnboarding() {
        let onboardingVC = OnboardingRouter.assembleModule(coordinator: self)
        navigationController.viewControllers = [onboardingVC]
    }
    
    func showAuthorization() {
        let authorizationVC = AuthorizationRouter.assembleModule()
        navigationController.viewControllers = [authorizationVC]
    }
}

