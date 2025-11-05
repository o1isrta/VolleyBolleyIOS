//
//  OnboardingRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 30.09.2025.
//

import Foundation

final class OnboardingRepository: OnboardingRepositoryProtocol {

    // MARK: - Public properties

    var isOnboardingShown: Bool {
        storage.get(for: .onboardingShown) ?? false
    }

    // MARK: - Private properties

    private let storage: SettingsStorageProtocol

    // MARK: - Initializers

    init(storage: SettingsStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Public methods

    func markAsShown() {
        storage.set(true, for: .onboardingShown)
    }

    func reset() {
        storage.remove(for: .onboardingShown)
    }
}
