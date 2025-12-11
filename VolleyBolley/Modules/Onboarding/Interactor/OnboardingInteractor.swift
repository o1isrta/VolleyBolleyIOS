//
//  OnboardingInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

protocol OnboardingInteractorProtocol: AnyObject {
	func markOnboardingAsCompleted()
}

final class OnboardingInteractor: OnboardingInteractorProtocol {

	// MARK: - Private Properties

	private let userSessionService: UserSessionServiceProtocol

	// MARK: - Initializers

	init(userSessionService: UserSessionServiceProtocol) {
		self.userSessionService = userSessionService
	}

	// MARK: - Public Methods

	func markOnboardingAsCompleted() {
		userSessionService.markOnboardingAsShown()
	}
}
