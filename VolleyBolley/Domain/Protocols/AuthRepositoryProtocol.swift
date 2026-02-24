//
//  AuthRepositoryProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 27.09.2025.
//

import Foundation

protocol AuthRepositoryProtocol {
	func loginWithGoogle(idToken: String) async throws -> AuthResult
}
