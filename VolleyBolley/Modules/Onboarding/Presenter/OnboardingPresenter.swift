//
//  OnboardingPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import Foundation

protocol OnboardingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapContinue()
}

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
        let item = interactor.getWelcomeItem()
        view?.configureView(with: item)
    }

    func didTapContinue() {
        interactor.markOnboardingShown()
        router.onFinish?()
    }
}
