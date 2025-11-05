//
//  SettingsStorage.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

struct SettingsKey<Value> {
    let name: String
}

extension SettingsKey where Value == Bool {
    static let onboardingShown = SettingsKey<Bool>(name: "onboardingShown")
}

final class SettingsStorage: SettingsStorageProtocol {

    // MARK: - Private properties

    private let defaults: UserDefaults

    // MARK: - Initializers

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Public methods

    func get<Value>(for key: SettingsKey<Value>) -> Value? {
        defaults.object(forKey: key.name) as? Value
    }

    func set<Value>(_ value: Value, for key: SettingsKey<Value>) {
        defaults.set(value, forKey: key.name)
    }

    func remove<Value>(for key: SettingsKey<Value>) {
        defaults.removeObject(forKey: key.name)
    }
}
