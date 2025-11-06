//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func didTapContinueWithGoogle()
}

// TODO: - show loading state

final class AuthPresenter: AuthPresenterProtocol {

    // MARK: - Public properties

    weak var view: AuthViewProtocol?

    // MARK: - Private properties

    private let interactor: AuthInteractorProtocol
    private let router: AuthRouterProtocol

    // MARK: - Initializers

    init(
        interactor: AuthInteractorProtocol,
        router: AuthRouterProtocol,
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public methods

    func didTapContinueWithGoogle() {
        interactor.loginWithGoogle()
    }
}

// MARK: - AuthInteractorOutput

extension AuthPresenter: AuthInteractorOutput {

    func didLoginSuccessfully() {
        DispatchQueue.main.async { [weak self] in
            self?.router.finishAuth()
        }
    }

    func didFailToLogin(error: Error) {
        print("❌ AuthPresenter - didFailToLogin: \(error)")
        // TODO: Show alert
        //        DispatchQueue.main.async { [weak self] in
        //            self?.view?.showError(error.localizedDescription)
        //        }
    }
}
