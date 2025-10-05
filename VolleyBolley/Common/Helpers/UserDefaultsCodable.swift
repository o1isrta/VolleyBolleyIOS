//
//  UserDefaultsCodable.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 05.10.2025.
//

import Foundation

/// Property wrapper for storing Codable types in UserDefaults with automatic serialization.
///
/// ## Features:
/// - Automatically encodes and decodes Codable types to/from Data
/// - Stores serialized data in UserDefaults
/// - Provides type-safe access to complex custom types
/// - Handles encoding/decoding errors gracefully by returning default value
///
/// ## Supported Types:
/// - Custom structs and classes conforming to Codable
/// - Complex nested objects
/// - Arrays and dictionaries of Codable types
/// - Enums with associated values (if Codable)
///
/// ## Usage Example:
/// ```swift
/// struct User: Codable {
///     let name: String
///     let age: Int
///     let email: String
/// }
///
/// class UserManager {
///     @UserDefaultsCodable(key: "currentUser", defaultValue: User(name: "", age: 0, email: ""))
///     var currentUser: User
/// }
/// ```
///
/// ## Important Notes:
/// - The type must conform to Codable protocol
/// - Encoding failures return the default value
/// - Decoding failures return the default value
/// - Data is stored as JSON in UserDefaults
@propertyWrapper
struct UserDefaultsCodable<T: Codable> {
	private let key: String
	private let userDefaults: UserDefaults
	private let defaultValue: T

	/// Initializes the property wrapper for Codable types
	///
	/// - Parameters:
	///   - key: The key for storing data in UserDefaults
	///   - defaultValue: The default value to return if data doesn't exist or decoding fails
	///   - userDefaults: UserDefaults instance to use (default: .standard)
	init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard) {
		self.key = key
		self.defaultValue = defaultValue
		self.userDefaults = userDefaults
	}

	var wrappedValue: T {
		get {
			guard let data = userDefaults.data(forKey: key),
				  let value = try? JSONDecoder().decode(T.self, from: data) else {
				return defaultValue
			}
			return value
		}
		set {
			if let data = try? JSONEncoder().encode(newValue) {
				userDefaults.set(data, forKey: key)
			}
		}
	}
}
