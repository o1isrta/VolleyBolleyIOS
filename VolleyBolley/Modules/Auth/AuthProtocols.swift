//
//  AuthProtocols.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Foundation

protocol AuthViewProtocol: AnyObject {

}

protocol AuthPresenterProtocol: AnyObject {
    func phoneButtonTapped()
    func googleButtonTapped()
    func facebookButtonTapped()
    func didAuthWithGoogleSuccess()
    func didAuthWithFacebookSuccess()
}

protocol AuthInteractorProtocol: AnyObject {
    func authWithGoogle()
    func authWithFacebook()
}

protocol AuthInteractorOutputProtocol: AnyObject {
    func didAuthWithGoogleSuccess()
    func didAuthWithFacebookSuccess()
}

protocol AuthRouterProtocol: AnyObject {
    func showPhoneAuth()
    func showUserRegScreen()
}

