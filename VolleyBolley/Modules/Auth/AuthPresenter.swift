//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//
import Foundation

final class AuthorizationPresenter: AuthPresenterProtocol {

    weak var view: AuthViewProtocol?
    private let interactor: AuthInteractorProtocol
    private let router: AuthRouterProtocol

    init(view: AuthViewProtocol,
         interactor: AuthInteractorProtocol,
         router: AuthRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func phoneButtonTapped() {
        router.showPhoneAuth()
    }

    func googleButtonTapped() {
        interactor.authWithGoogle()
    }
}

extension AuthorizationPresenter: AuthInteractorOutputProtocol {
    func didAuthWithGoogleSuccess() {
        router.showUserRegScreen()
    }
}
