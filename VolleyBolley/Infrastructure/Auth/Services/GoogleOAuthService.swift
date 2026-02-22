//
//  GoogleOAuthService.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import GoogleSignIn

protocol GoogleOAuthServiceProtocol {
	func signIn(using context: PresentationContextProvider) async throws -> (idToken: String, accessToken: String)
}

protocol PresentationContextProvider {
	var presentingViewController: UIViewController { get }
}

final class GoogleOAuthService: GoogleOAuthServiceProtocol {

	// MARK: - Public Methods

	@MainActor
	func signIn(using context: PresentationContextProvider) async throws -> (idToken: String, accessToken: String) {
		let presentingVC = context.presentingViewController

		// TODO: - add logger
		do {
			let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC)
			guard let idToken = result.user.idToken?.tokenString else {
				throw DomainError.auth(.missingIDToken)
			}
			return (idToken, result.user.accessToken.tokenString)

		} catch let error as NSError {
			print("❌ GoogleOAuthService.signIn error: \(error)")
			throw mapToDomain(error)

		} catch {
			print("❌ GoogleOAuthService.signIn error: \(error)")
			throw DomainError.unknown
		}
	}

	// MARK: - Private Methods

	private func mapToDomain(_ error: NSError) -> DomainError {
		guard let code = GIDSignInError.Code(rawValue: error.code) else {
			return DomainError.unknown
		}

		switch code {
		case .canceled:
			return .auth(.signInCancelled)
		case .keychain:
			return .auth(.keychainError)
		case .hasNoAuthInKeychain:
			return .auth(.noAuthInKeychain)
		case .mismatchWithCurrentUser:
			return .auth(.mismatchWithCurrentUser)
		case .scopesAlreadyGranted:
			return .auth(.scopesAlreadyGranted)
		case .EMM:
			return .auth(.emm)
		case .unknown:
			return .auth(.signInFailed)
		case .ambiguousClaims, .jsonSerializationFailure:
			return .unknown
		@unknown default:
			return .unknown
		}
	}
}
