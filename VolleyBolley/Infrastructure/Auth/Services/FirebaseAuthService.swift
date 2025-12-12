//
//  FirebaseAuthService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.10.2025.
//

import FirebaseAuth

protocol FirebaseAuthServiceProtocol {
    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String
}

final class FirebaseAuthService: FirebaseAuthServiceProtocol {

    // MARK: - Public Methods

    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        do {
            let authResult = try await Auth.auth().signIn(with: credential)
            let idToken = try await authResult.user.getIDToken()
            return idToken
        } catch {
            // TODO: - add logger
            print("❌ FirebaseAuthService.signInWithGoogle - error:", error)
            throw mapToDomain(error)
        }
    }

    // MARK: - Private Methods

    private func mapToDomain(_ error: Error) -> DomainError {
        let nsError = error as NSError

        guard nsError.domain == AuthErrorDomain else {
            return DomainError.unknown
        }

        switch AuthErrorCode(rawValue: nsError.code) {
        case .invalidCredential:
            return .auth(.invalidCredentials)
        case .userDisabled:
            return .auth(.userDisabled)
        case .networkError:
            return .auth(.networkError)
        case .tooManyRequests:
            return .auth(.tooManyRequests)
        default:
            return DomainError.unknown
        }
    }
}
