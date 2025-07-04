import Foundation

final class UserDefaultsStorage: SettingsStorageProtocol {
    private let defaults = UserDefaults.standard

    func bool(forKey key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func set(_ value: Bool, forKey key: String) {
        defaults.set(value, forKey: key)
    }
}
