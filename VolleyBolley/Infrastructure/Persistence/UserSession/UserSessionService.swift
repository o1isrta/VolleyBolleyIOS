//
//  DefaultUserSessionService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

final class UserSessionService: UserSessionServiceProtocol {

    // MARK: - Public properties

    var isOnboardingShown: Bool {
        let value = storage.bool(forKey: "onboarding_shown")

        return value
    }

    var isAuthorized: Bool {
        let value = storage.bool(forKey: "authorized")

        return value
    }

    // MARK: - Private properties

    private let storage: SettingsStorageProtocol

    // MARK: - Initializers

    init(storage: SettingsStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Public methods

    func markOnboardingAsShown() {
        storage.set(true, forKey: "onboarding_shown")
    }

    func markUserAuthorized() {
        storage.set(true, forKey: "authorized")
    }
}
