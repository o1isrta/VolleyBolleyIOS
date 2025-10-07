//
//  SettingsStorageProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol SettingsStorageProtocol {
    func bool(forKey: String) -> Bool
    func set(_ value: Bool, forKey: String)
}
