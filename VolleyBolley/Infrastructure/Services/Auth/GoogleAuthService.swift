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

        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC)
        let user = signInResult.user

        guard let idToken = user.idToken?.tokenString else {
            throw AuthError.missingIDToken
        }

        let accessToken = user.accessToken.tokenString

        return (idToken, accessToken)
    }
}
