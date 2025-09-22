//
//  UserSessionService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

final class UserSessionService: UserSessionServiceProtocol {
    private let storage: SettingsStorageProtocol

    init(storage: SettingsStorageProtocol) {
        self.storage = storage
    }

    var isOnboardingShown: Bool {
        let value = storage.bool(forKey: "onboarding_shown")

        return value
    }

    var isAuthorized: Bool {
        let value = storage.bool(forKey: "authorized")

        return value
    }

    func markOnboardingAsShown() {
        storage.set(true, forKey: "onboarding_shown")
    }

    func markUserAuthorized() {
        storage.set(true, forKey: "authorized")
    }
}
