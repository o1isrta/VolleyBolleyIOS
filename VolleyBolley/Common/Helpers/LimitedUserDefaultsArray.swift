//
//  LimitedUserDefaultsArray.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 05.10.2025.
//

import Foundation

/// Property wrapper for managing arrays with size limitation and automatic saving to UserDefaults.
///
/// ## Features:
/// - Automatically limits array size to the specified limit
/// - Saves data to UserDefaults between app launches
/// - New elements are added to the beginning of the array, old ones are pushed out when limit is exceeded
/// - Supports any types conforming to Codable protocols
///
/// ## Usage Example:
/// ```swift
/// class NotificationManager {
///     @LimitedUserDefaultsArray(key: "notifications", limit: 50)
///     private(set) var notifications: [Notification] = []
/// }
/// ```
@propertyWrapper
struct LimitedUserDefaultsArray<Value: Codable> {

	private let key: String
	private let limit: Int
	private let userDefaults: UserDefaults

	/// Property wrapper initializer
	///
	/// - Parameters:
	///   - key: Key for saving to UserDefaults
	///   - limit: Maximum number of elements in the array (default: 100)
	///   - userDefaults: UserDefaults instance for saving (default: .standard)
	init(
		key: String,
		limit: Int = 100,
		userDefaults: UserDefaults = .standard
	) {
		self.key = key
		self.limit = limit
		self.userDefaults = userDefaults
	}

	var wrappedValue: [Value] {
		get {
			guard
				let data = userDefaults.data(forKey: key),
				let array = try? JSONDecoder().decode([Value].self, from: data)
			else {
				return []
			}
			return array
		}
		set {
			var newArray = newValue
			// If new array exceeds the limit, truncate it
			if newArray.count > limit {
				newArray = Array(newArray.prefix(limit))
			}

			if let data = try? JSONEncoder().encode(newArray) {
				userDefaults.set(data, forKey: key)
			}
		}
	}
}
