//
//  KeychainHelper.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.09.2025.
//

import Foundation
import Security

/// Represents errors that occur during Keychain operations.
///
/// These errors wrap the underlying `OSStatus` codes returned by Security.framework APIs.
enum KeychainError: Error {
	/// An unhandled error occurred during a Keychain operation.
	/// - Parameter status: The OSStatus code returned by the Security API.
	case unhandledError(status: OSStatus)
}

/// A helper type for securely storing, retrieving, and deleting string values in the iOS/macOS Keychain.
///
/// Uses `kSecClassGenericPassword` for cross-platform compatibility.
/// Ideal for storing sensitive data like access tokens, refresh tokens, or secrets.
struct KeychainHelper {

	/// Saves a string value to the Keychain under the specified key and service identifier.
	///
	/// If an item with the same key already exists, it will be overwritten.
	///
	/// - Parameters:
	///   - value: The string to store (e.g., an access token).
	///   - key: A unique identifier for the item (e.g., "access_token").
	///   - service: The service name (typically your app’s bundle identifier).
	/// - Throws: `KeychainError.unhandledError` if the operation fails.
	static func save(
		_ value: String,
		forKey key: String,
		service: String
	) throws {
		let data = value.data(using: .utf8)!
		let query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrService: service,
			kSecAttrAccount: key,
			kSecValueData: data
		]

		// Delete any existing item first to avoid duplicates
		SecItemDelete(query as CFDictionary)

		let status = SecItemAdd(query as CFDictionary, nil)
		guard status == errSecSuccess else {
			throw KeychainError.unhandledError(status: status)
		}
	}

	/// Loads a string value from the Keychain using the specified key and service.
	///
	/// - Parameters:
	///   - key: The unique identifier for the item (e.g., "refresh_token").
	///   - service: The service name.
	/// - Returns: The stored string, or `nil` if not found or an error occurred.
	static func load(forKey key: String, service: String) -> String? {
		let query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrService: service,
			kSecAttrAccount: key,
			kSecReturnData: true,
			kSecMatchLimit: kSecMatchLimitOne
		]

		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)

		guard status == errSecSuccess, let data = item as? Data else {
			return nil
		}

		return String(data: data, encoding: .utf8)
	}

	/// Deletes an item from the Keychain using the specified key and service.
	///
	/// - Parameters:
	///   - key: The unique identifier of the item to delete.
	///   - service: The service name.
	/// - Throws: `KeychainError.unhandledError` if an unexpected error occurs (excluding "item not found").
	static func delete(forKey key: String, service: String) throws {
		let query: [CFString: Any] = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrService: service,
			kSecAttrAccount: key
		]

		let status = SecItemDelete(query as CFDictionary)
		if status != errSecSuccess && status != errSecItemNotFound {
			throw KeychainError.unhandledError(status: status)
		}
	}
}
