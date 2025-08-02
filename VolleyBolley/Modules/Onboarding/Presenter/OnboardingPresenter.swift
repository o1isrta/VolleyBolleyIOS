//
//  OnboardingPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    let interactor: OnboardingInteractorProtocol
    let router: OnboardingRouterProtocol

    // MARK: - Initializers

    init(interactor: OnboardingInteractorProtocol, router: OnboardingRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
//        let item = interactor.getWelcomeItem()
//        view?.configureView(with: item)
    }

    func didTapGetStartedButton() {
        interactor.markOnboardingShown()
        router.onFinish?()
    }
}
