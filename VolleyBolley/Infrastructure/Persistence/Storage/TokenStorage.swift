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
}

final class TokenStorage: TokenStorageProtocol {

	static let shared = TokenStorage()
	private init() {}

	// TODO: need save to keychain

	var accessToken: String? {
		get { UserDefaults.standard.string(forKey: "access_token") }
		set { UserDefaults.standard.set(newValue, forKey: "access_token") }
	}

	var refreshToken: String? {
		get { UserDefaults.standard.string(forKey: "refresh_token") }
		set { UserDefaults.standard.set(newValue, forKey: "refresh_token") }
	}
}
