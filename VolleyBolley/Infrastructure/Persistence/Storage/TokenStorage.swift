//
//  TokenStorage.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

protocol TokenStorageProtocol {
	var accessToken: String? { get set }
	var refreshToken: String? { get set }
	func clearAllTokens()
}

final class TokenStorage: TokenStorageProtocol {

	static let shared = TokenStorage()
	private init() {}

	@KeychainStored(key: "access_token")
	var accessToken: String?

	@KeychainStored(key: "refresh_token")
	var refreshToken: String?

	func clearAllTokens() {
		accessToken = nil
		refreshToken = nil
	}
}
