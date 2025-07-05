import Swinject

final class SharedServicesAssembly: Assembly {

    func assemble(container: Container) {

        container.register(SettingsStorageProtocol.self) { _ in
            UserDefaultsStorage()
        }
        .inObjectScope(.container)

        container.register(UserSessionServiceProtocol.self) { resolver in
            guard let storage = resolver.resolve(SettingsStorageProtocol.self) else {
                fatalError("❌ Failed to resolve SettingsStorageProtocol")
            }
            return DefaultUserSessionService(storage: storage)
        }
        .inObjectScope(.container)
    }
}
