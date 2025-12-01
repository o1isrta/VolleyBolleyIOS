//
//  DefaultUserSessionService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

final class UserSessionService: UserSessionServiceProtocol {

    // MARK: - Public properties

    @UserDefaultsCodable(key: AppConstants.UserDefaultsKeys.onboardingShown, defaultValue: false)
    private(set) var isOnboardingShown: Bool

    @UserDefaultsCodable(key: AppConstants.UserDefaultsKeys.authorized, defaultValue: false)
    private(set) var isAuthorized: Bool

    // MARK: - Public methods

    func markOnboardingAsShown() {
        isOnboardingShown = true
    }

    func markUserAuthorized() {
        isAuthorized = true
    }
}
