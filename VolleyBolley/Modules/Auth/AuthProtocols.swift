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
}

protocol AuthInteractorProtocol: AnyObject {
    func authWithGoogle()
}

protocol AuthInteractorOutputProtocol: AnyObject {
    func didAuthWithGoogleSuccess()
}

protocol AuthRouterProtocol: AnyObject {
    func showPhoneAuth()
    func showUserRegScreen()
}
