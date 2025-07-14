//
//  DefaultUserSessionService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

protocol UserSessionServiceProtocol {
    var isOnboardingShown: Bool { get }
    var isAuthorized: Bool { get }
    func markOnboardingAsShown()
    func markUserAuthorized()
}

final class DefaultUserSessionService: UserSessionServiceProtocol {
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
