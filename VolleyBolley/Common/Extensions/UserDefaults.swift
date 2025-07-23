//
//  UserDefaults.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

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
