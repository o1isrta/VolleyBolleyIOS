//
//  FirebaseAuthService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 09.10.2025.
//

import FirebaseAuth

final class FirebaseAuthService: FirebaseAuthServiceProtocol {

    func signInWithGoogle(idToken: String, accessToken: String) async throws -> String {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        do {
            let authResult = try await Auth.auth().signIn(with: credential)
            let idToken = try await authResult.user.getIDToken()
            return idToken
        } catch {
            throw mapFirebaseError(error)
        }
    }

    private func mapFirebaseError(_ error: Error) -> FirebaseAuthError {
        let nsError = error as NSError

        guard nsError.domain == AuthErrorDomain else {
            return .unknown(error)
        }

        switch AuthErrorCode(rawValue: nsError.code) {
        case .invalidCredential:
            return .invalidCredentials
        case .userDisabled:
            return .userDisabled
        case .networkError:
            return .networkError
        case .tooManyRequests:
            return .tooManyRequests
        default:
            return .unknown(error)
        }
    }
}
