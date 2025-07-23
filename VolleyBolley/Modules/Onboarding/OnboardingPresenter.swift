//
//  OnboardingPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    private let interactor: OnboardingInteractorProtocol
    private let router: OnboardingRouterProtocol
    
    init(view: OnboardingViewProtocol,
         interactor: OnboardingInteractorProtocol,
         router: OnboardingRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func getStartedButtonTapped() {
        interactor.markOnboardingAsCompleted()
        router.navigateToAuthorizationScreen()
    }
}
