import Foundation

protocol OnboardingViewProtocol: AnyObject {
    
}

protocol OnboardingPresenterProtocol: AnyObject {
    func getStartedButtonTapped()
}

protocol OnboardingInteractorProtocol: AnyObject {
    func markOnboardingAsCompleted()
}

protocol OnboardingRouterProtocol: AnyObject {
    func navigateToAuthorizationScreen()
}
