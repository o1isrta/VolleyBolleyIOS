//
//  AuthPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//
import Foundation

class AuthorizationPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?

    func phoneButtonTapped() {
        router?.showPhoneAuth()
    }

    func googleButtonTapped() {
        interactor?.authWithGoogle()
    }

    func facebookButtonTapped() {
        interactor?.authWithFacebook()
    }
}


extension AuthorizationPresenter: AuthInteractorOutputProtocol {
    func didAuthWithGoogleSuccess() {
        router?.showUserRegScreen()
    }

    func didAuthWithFacebookSuccess() {
        router?.showUserRegScreen()
    }
}
