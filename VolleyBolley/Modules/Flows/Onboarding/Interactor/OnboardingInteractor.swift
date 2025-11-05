//
//  OnboardingInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

protocol OnboardingInteractorProtocol: AnyObject {
    func markOnboardingAsCompleted()
}

final class OnboardingInteractor: OnboardingInteractorProtocol {

    // MARK: - Private Properties

    private let onboardingRepository: OnboardingRepositoryProtocol

    // MARK: - Initializers

    init(
        onboardingRepository: OnboardingRepositoryProtocol
    ) {
        self.onboardingRepository = onboardingRepository
    }

    // MARK: - Public methods

    func markOnboardingAsCompleted() {
        onboardingRepository.markAsShown()
    }
}
