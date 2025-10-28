//
//  AuthInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Foundation

protocol AuthInteractorProtocol: AnyObject {
    func authWithGoogle()
}

protocol AuthInteractorOutputProtocol: AnyObject {
    func didAuthWithGoogleSuccess()
}

final class AuthorizationInteractor: AuthInteractorProtocol {

    weak var presenter: AuthInteractorOutputProtocol?

    func authWithGoogle() {
        presenter?.didAuthWithGoogleSuccess()
    }
}
