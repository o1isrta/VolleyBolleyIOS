//
//  AuthInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//
import Foundation

final class AuthorizationInteractor: AuthInteractorProtocol {
    
    weak var presenter: AuthInteractorOutputProtocol?

    func authWithGoogle() {
        presenter?.didAuthWithGoogleSuccess()
    }
}
