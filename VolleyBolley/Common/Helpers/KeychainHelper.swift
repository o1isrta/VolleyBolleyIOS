//
//  KeychainHelper.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 20.09.2025.
//

import Foundation
import Security

enum KeychainError: Error {
	case unhandledError(status: OSStatus)
}

struct KeychainHelper {

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

		SecItemDelete(query as CFDictionary)

		let status = SecItemAdd(query as CFDictionary, nil)
		guard status == errSecSuccess else {
			throw KeychainError.unhandledError(status: status)
		}
	}

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
