//
//  TokenStorage.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 10.09.2025.
//

import Foundation

/// Defines the interface for managing authentication tokens.
///
/// Used to abstract token storage for testing or alternative implementations.
protocol TokenStorageProtocol {
    /// The current access token. Can be read or set to persist in secure storage.
    var accessToken: String? { get set }

    /// The current refresh token. Can be read or set to persist in secure storage.
    var refreshToken: String? { get set }

    /// Clears all stored tokens.
    func clearAllTokens()
}

/// A singleton implementation of `TokenStorageProtocol` that securely stores tokens in the Keychain.
///
/// Uses `@KeychainStored` property wrappers to automatically persist token values.
/// Thread-safe for basic usage (Keychain operations are serialized by the system).
///
/// ### Usage
///
/// Save tokens after successful authentication:
/// ```swift
/// TokenStorage.shared.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.xxxxx"
/// TokenStorage.shared.refreshToken = "rt_xxxxx_refresh_xxxxx"
/// ```
///
/// Check if user is logged in:
/// ```swift
/// if let token = TokenStorage.shared.accessToken {
///     print("User is authenticated with token: \(token.prefix(10))...")
/// } else {
///     print("User is not logged in.")
/// }
/// ```
///
/// Clear tokens on logout:
/// ```swift
/// TokenStorage.shared.clearAllTokens()
/// ```
///
/// All values are automatically persisted to or deleted from Keychain — no manual save/load required.
final class TokenStorage: TokenStorageProtocol {

    private enum Constants: String {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }

    /// Shared singleton instance.
    static let shared = TokenStorage()

    /// Private initializer to enforce singleton pattern.
    private init() {}

    /// Access token persisted securely in Keychain under key "access_token".
    @KeychainStored(key: Constants.accessToken.rawValue)
    var accessToken: String?

    /// Refresh token persisted securely in Keychain under key "refresh_token".
    @KeychainStored(key: Constants.refreshToken.rawValue)
    var refreshToken: String?

    /// Removes all stored tokens by setting them to `nil`.
    ///
    /// This triggers deletion from Keychain via the property wrappers.
    func clearAllTokens() {
        accessToken = nil
        refreshToken = nil
    }
}
