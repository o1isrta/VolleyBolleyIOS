//
//  SettingsStorageProtocol.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol SettingsStorageProtocol {
    func get<Value>(for key: SettingsKey<Value>) -> Value?
    func set<Value>(_ value: Value, for key: SettingsKey<Value>)
    func remove<Value>(for key: SettingsKey<Value>)
}
