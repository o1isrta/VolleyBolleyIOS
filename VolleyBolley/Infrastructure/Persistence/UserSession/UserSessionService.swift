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
		let value = storage.bool(forKey: AppConstants.UserDefaultsKeys.onboardingShown)

        return value
    }

    var isAuthorized: Bool {
		let value = storage.bool(forKey: AppConstants.UserDefaultsKeys.authorized)

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
        storage.set(true, forKey: AppConstants.UserDefaultsKeys.onboardingShown)
    }

    func markUserAuthorized() {
        storage.set(true, forKey: AppConstants.UserDefaultsKeys.authorized)
    }
}
