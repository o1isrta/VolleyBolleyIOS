//
//  AuthInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import Combine
import UIKit

protocol AuthInteractorProtocol: AnyObject {
    var statePublisher: AnyPublisher<AuthViewState, Never> { get }
    func loginWithGoogle()
}

final class AuthInteractor: AuthInteractorProtocol {

    var statePublisher: AnyPublisher<AuthViewState, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    private let stateSubject = PassthroughSubject<AuthViewState, Never>()

    // MARK: - Private Properties

    private let googleAuthService: GoogleAuthServiceProtocol
    private let firebaseAuthService: FirebaseAuthServiceProtocol
    private let authRepository: AuthRepositoryProtocol
    private let sessionRepository: SessionRepositoryProtocol
    private let router: AuthRouterProtocol

    // MARK: - Initializers

    init(
        googleAuthService: GoogleAuthServiceProtocol,
        firebaseAuthService: FirebaseAuthServiceProtocol,
        authRepository: AuthRepositoryProtocol,
        sessionRepository: SessionRepositoryProtocol,
        router: AuthRouterProtocol
    ) {
        self.googleAuthService = googleAuthService
        self.firebaseAuthService = firebaseAuthService
        self.authRepository = authRepository
        self.sessionRepository = sessionRepository
        self.router = router
    }

    // MARK: - Public Methods

    // TODO: - remove debug print
    func loginWithGoogle() {
        stateSubject.send(.loading)
        Task {
            do {
                let googleTokens = try await googleAuthService.signIn(using: router)
                print("✅ AuthInteractor - Авторизация через Google - idToken: \(googleTokens.idToken)")

                let firebaseIdToken = try await firebaseAuthService.signInWithGoogle(
                    idToken: googleTokens.idToken,
                    accessToken: googleTokens.accessToken
                )
                print("✅ AuthInteractor - Авторизация через Firebase - idToken: \(firebaseIdToken)")

                let result = try await authRepository.loginWithGoogle(idToken: firebaseIdToken)
                print("✅ AuthInteractor - Авторизация на сервере - result: \(result)")

                try sessionRepository.save(session: result.session)
                print("✅ AuthInteractor - Сессия сохранена в Keychain")
                print("✅ AuthInteractor - Сессия: \(String(describing: sessionRepository.currentSession))")

                stateSubject.send(.success)
            } catch {
                print("❌ AuthInteractor - error:", error)
                stateSubject.send(.alertError(error.localizedDescription))
            }
        }
    }
}
