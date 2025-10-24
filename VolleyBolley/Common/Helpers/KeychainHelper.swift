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
/// These errors wrap the underlying `OSStatus` codes returned by Security.framework APIs
/// or represent logical failures such as string encoding issues.
enum KeychainError: Error {
	/// An unhandled error occurred during a Keychain operation.
	/// - Parameter status: The `OSStatus` code returned by the Security API.
	case unhandledError(status: OSStatus)

	/// The string could not be encoded into UTF-8 data, which is required for Keychain storage.
	///
	/// This should be extremely rare in practice, as all Swift `String` values are UTF-8 compatible,
	/// but it's included for API completeness and safety.
	case encodingFailed
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
	///   - key: A unique identifier for the item (e.g., `"access_token"`).
	///   - service: The service name (typically your app’s bundle identifier).
	/// - Throws:
	///   - `KeychainError.encodingFailed` if the string cannot be encoded as UTF-8 (highly unlikely).
	///   - `KeychainError.unhandledError` if the underlying Keychain operation fails.
	static func save(
		_ value: String,
		forKey key: String,
		service: String
	) throws {
		guard let data = value.data(using: .utf8) else {
			throw KeychainError.encodingFailed
		}

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
	///   - key: The unique identifier for the item (e.g., `"refresh_token"`).
	///   - service: The service name (typically your app’s bundle identifier).
	/// - Returns: The stored string, or `nil` if the item is not found, corrupted, or an error occurred.
	///   Note: This method does **not** throw — failures are silent and result in `nil`.
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
	/// It is **not** an error if the item does not exist.
	///
	/// - Parameters:
	///   - key: The unique identifier of the item to delete.
	///   - service: The service name (typically your app’s bundle identifier).
	/// - Throws: `KeychainError.unhandledError` only if an unexpected error occurs
	///   (e.g., permission denied). If the item is not found (`errSecItemNotFound`), no error is thrown.
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
