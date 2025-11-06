//
//  SecureStorageProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 29.09.2025.
//

import Foundation

protocol SecureStorageProtocol {
    func save<T: Codable>(_ value: T, forKey key: String) throws
    func load<T: Codable>(forKey key: String) -> T?
    func remove(forKey key: String) throws
}
