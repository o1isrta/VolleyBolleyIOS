import Foundation

class OnboardingInteractor: OnboardingInteractorProtocol {
    
    func markOnboardingAsCompleted() {
        UserDefaults.standard.isOnboardingShown = true
    }
}
