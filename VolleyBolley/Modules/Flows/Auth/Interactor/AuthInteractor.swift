//
//  AuthInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import UIKit

protocol AuthInteractorProtocol: AnyObject {
    func loginWithGoogle()
}

protocol AuthInteractorOutput: AnyObject {
    func didLoginSuccessfully()
    func didFailToLogin(error: Error)
}

final class AuthInteractor: AuthInteractorProtocol {

    // MARK: - Public Properties

    weak var presenter: AuthInteractorOutput?

    // MARK: - Private Properties

    private let googleAuthService: GoogleAuthServiceProtocol
    private let firebaseAuthService: FirebaseAuthServiceProtocol
    private let authRepository: AuthRepositoryProtocol
    private let router: AuthRouterProtocol

    // MARK: - Initializers

    init(
        googleAuthService: GoogleAuthServiceProtocol,
        firebaseAuthService: FirebaseAuthServiceProtocol,
        authRepository: AuthRepositoryProtocol,
        router: AuthRouterProtocol
    ) {
        self.googleAuthService = googleAuthService
        self.firebaseAuthService = firebaseAuthService
        self.authRepository = authRepository
        self.router = router
    }

    // MARK: - Public Methods

    func loginWithGoogle() {
        Task {
            do {
                let googleIdToken = try await googleAuthService.signIn(using: router)
                let firebaseIdToken = try await firebaseAuthService.signInWithGoogle(
                    idToken: googleIdToken.idToken, accessToken: googleIdToken.accessToken
                )
                let result = try await authRepository.loginWithGoogle(idToken: firebaseIdToken)

                print("✅ Успешная авторизация через Google: \(result)")
            } catch {
                print("❌ Ошибка авторизации через Google: \(error)")
                presenter?.didFailToLogin(error: error)
            }
        }
    }
}
