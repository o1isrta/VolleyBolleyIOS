//
//  KeychainStorage.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation
import Security

final class KeychainStorage: SecureStorageProtocol {

    func save<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw NSError(domain: "Keychain", code: Int(status), userInfo: nil)
        }
    }

    func load<T: Codable>(forKey key: String) -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let value = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }

        return value
    }

    func remove(forKey key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw NSError(domain: "Keychain", code: Int(status), userInfo: nil)
        }
    }
}
