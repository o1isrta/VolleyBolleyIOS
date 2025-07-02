// Storage Abstraction
protocol SettingsStorageProtocol {
    func bool(forKey: String) -> Bool
    func set(_ value: Bool, forKey: String)
}
