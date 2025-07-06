import Foundation

extension UserDefaults {
    
    var isOnboardingShown: Bool {
        get {
            bool(forKey: UserDefaultsKeys.onboardingShown)
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.onboardingShown)
            synchronize()
        }
    }
}
