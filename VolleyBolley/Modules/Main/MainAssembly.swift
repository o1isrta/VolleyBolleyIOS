import Swinject

class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainAppRouterProtocol.self) { resolver in
            MainAppRouter(resolver: resolver)
        }
    }
}
