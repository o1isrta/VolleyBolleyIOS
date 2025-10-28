//
//  OnboardingPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
	func getStartedButtonTapped()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {

	// MARK: - Public Properties

	weak var view: OnboardingViewProtocol?

	// MARK: - Private Properties

	private let interactor: OnboardingInteractorProtocol
	private let router: OnboardingRouterProtocol

	// MARK: - Initializers

	init(
		view: OnboardingViewProtocol,
		interactor: OnboardingInteractorProtocol,
		router: OnboardingRouterProtocol
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func getStartedButtonTapped() {
		interactor.markOnboardingAsCompleted()
		router.navigateToAuthorizationScreen()
	}
}
