//
//  AuthRepository.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 27.09.2025.
//

import Foundation

struct AuthResult {
	let session: PlayerSession
	let currentPlayerDTO: CurrentPlayerDTO
}

final class AuthRepository: AuthRepositoryProtocol {

	// MARK: - Private Properties

	private let service: NetworkServiceProtocol

	// MARK: - Initializers

	init(service: NetworkServiceProtocol) {
		self.service = service
	}

	// MARK: - Public Methods

	func loginWithGoogle(idToken: String) async throws -> AuthResult {
		let dto: PlayerSessionDTO = try await service.googleAuth(idToken: idToken)
		let session: PlayerSession = dto.toDomain()
		let currentPlayerDTO = dto.player

		return AuthResult(session: session, currentPlayerDTO: currentPlayerDTO)
	}
}
