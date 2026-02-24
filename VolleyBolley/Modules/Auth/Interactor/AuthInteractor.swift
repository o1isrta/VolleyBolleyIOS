//
//  AuthInteractor.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 31.07.2025.
//

import UIKit

protocol AuthInteractorProtocol: AnyObject {
	func loginWithGoogle() async throws
}

final class AuthInteractor: AuthInteractorProtocol {

	// MARK: - Private Properties

	private let googleAuthService: GoogleOAuthServiceProtocol
	private let firebaseAuthService: FirebaseAuthServiceProtocol
	private let authRepository: AuthRepositoryProtocol
	private let router: AuthRouterProtocol

	// MARK: - Initializers

	init(
		googleAuthService: GoogleOAuthServiceProtocol,
		firebaseAuthService: FirebaseAuthServiceProtocol,
		authRepository: AuthRepositoryProtocol,
		router: AuthRouterProtocol,
	) {
		self.googleAuthService = googleAuthService
		self.firebaseAuthService = firebaseAuthService
		self.authRepository = authRepository
		self.router = router
	}

	// MARK: - Public Methods

	func loginWithGoogle() async throws {
		let googleTokens = try await googleAuthService.signIn(using: router)
		print("✅ AuthInteractor.loginWithGoogle - googleTokens: \(googleTokens)")

		let firebaseIdToken = try await firebaseAuthService.signInWithGoogle(
			idToken: googleTokens.idToken,
			accessToken: googleTokens.accessToken
		)
		print("✅ AuthInteractor.loginWithGoogle - firebaseIdToken: \(firebaseIdToken)")

		let result = try await authRepository.loginWithGoogle(idToken: firebaseIdToken)
		print("✅ AuthInteractor.loginWithGoogle - result: \(result)")
	}
}
