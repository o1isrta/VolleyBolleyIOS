//
//  OnboardingInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

class OnboardingInteractor: OnboardingInteractorProtocol {
    private let userSessionService: UserSessionServiceProtocol

    init(userSessionService: UserSessionServiceProtocol) {
        self.userSessionService = userSessionService
    }

    // MARK: - Public Methods

    func markOnboardingShown() {
        userSessionService.markOnboardingAsShown()
    }
}
