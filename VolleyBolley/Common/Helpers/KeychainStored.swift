//
//  KeychainStored.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.09.2025.
//

import Foundation
import Security

/// A property wrapper that automatically persists a `String?` value to the Keychain.
///
/// On read: loads the value from Keychain.
/// On write: saves or deletes the value in Keychain.
/// Uses `KeychainHelper` internally for secure storage.
@propertyWrapper
struct KeychainStored {

	/// The unique key under which the value is stored in Keychain.
	private let key: String

	/// The service identifier (typically the app's bundle ID).
	private let service: String

	/// Initializes the wrapper with a key and optional service name.
	///
	/// - Parameters:
	///   - key: The unique storage key (e.g., "access_token").
	///   - service: The service name. Defaults to the app’s bundle identifier.
	///              If `Bundle.main.bundleIdentifier` is nil, falls back to `AppConstants.bundleIdentifier`.
	init(
		key: String,
		service: String = Bundle.main.bundleIdentifier ?? AppConstants.bundleIdentifier
	) {
		self.key = key
		self.service = service
	}

	/// The wrapped string value, automatically persisted to Keychain.
	///
	/// - Note: Errors during save/delete operations are silently ignored (`try?`).
	///         For critical operations, consider using `KeychainHelper` directly with error handling.
	var wrappedValue: String? {
		get {
			return KeychainHelper.load(forKey: key, service: service)
		}
		set {
			if let newValue = newValue {
				try? KeychainHelper.save(newValue, forKey: key, service: service)
			} else {
				try? KeychainHelper.delete(forKey: key, service: service)
			}
		}
	}
}
