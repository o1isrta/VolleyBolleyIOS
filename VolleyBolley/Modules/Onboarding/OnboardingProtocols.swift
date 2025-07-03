import UIKit

protocol OnboardingViewProtocol: AnyObject {
    
}

protocol OnboardingPresenterProtocol: AnyObject {
    func getStartedButtonTapped()
}

protocol OnboardingInteractorProtocol: AnyObject {
    
}

protocol OnboardingRouterProtocol: AnyObject {
    func navigateToAuthorizationScreen()
}
