//
//  KeychainStored.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.09.2025.
//

import Foundation
import Security

@propertyWrapper
struct KeychainStored {

	private let key: String
	private let service: String

	init(
		key: String,
		service: String = Bundle.main.bundleIdentifier ?? AppConstants.bundleIdentifier
	) {
		self.key = key
		self.service = service
	}

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
