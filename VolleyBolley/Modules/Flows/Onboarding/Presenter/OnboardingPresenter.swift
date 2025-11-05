//
//  OnboardingPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

protocol OnboardingPresenterProtocol: AnyObject {
    func didTapGetStarted()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {

    // MARK: - Public Properties

    weak var view: OnboardingViewProtocol?

    // MARK: - Private Properties

    private let interactor: OnboardingInteractorProtocol
    private let finishOnboardingFlow: () -> Void

    // MARK: - Initializers

    init(
        interactor: OnboardingInteractorProtocol,
        finishOnboardingFlow: @escaping () -> Void
    ) {
        self.interactor = interactor
        self.finishOnboardingFlow = finishOnboardingFlow
    }

    // MARK: - Public methods

    func didTapGetStarted() {
        interactor.markOnboardingAsCompleted()
        finishOnboardingFlow()
    }
}
