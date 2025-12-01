//
//  GoogleAuthService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import GoogleSignIn

protocol GoogleAuthServiceProtocol {
    func signIn(using context: PresentationContextProvider) async throws -> (idToken: String, accessToken: String)
}

protocol PresentationContextProvider {
    var presentingViewController: UIViewController { get }
}

final class GoogleAuthService: GoogleAuthServiceProtocol {

    private var continuation: CheckedContinuation<URL, Error>?

    // MARK: - Public Methods

    @MainActor
    func signIn(using context: PresentationContextProvider) async throws -> (idToken: String, accessToken: String) {
        let presentingVC = context.presentingViewController

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC)
            let user = result.user

            guard let idToken = user.idToken?.tokenString else {
                throw GoogleAuthError.missingIDToken
            }

            let accessToken = user.accessToken.tokenString
            return (idToken, accessToken)

        } catch let error as NSError {
            if error.code == GIDSignInError.canceled.rawValue {
                throw GoogleAuthError.signInCancelled
            } else {
                throw GoogleAuthError.signInFailed(error.localizedDescription)
            }
        } catch {
            throw GoogleAuthError.unknown(error)
        }
    }
}
