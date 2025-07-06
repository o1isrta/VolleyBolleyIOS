import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorProtocol?
    var router: OnboardingRouterProtocol?
    
    func getStartedButtonTapped() {
        interactor?.markOnboardingAsCompleted()
        router?.navigateToAuthorizationScreen()
    }
}
