import Swinject

final class AuthAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AuthViewController.self) { _ in
            let viewController = AuthViewController()
            // здесь можно будет позже добавить presenter/interactor
            return viewController
        }

        container.register(AuthRouterProtocol.self) { resolver in
            AuthRouter(resolver: resolver)
        }
        .inObjectScope(.transient)
    }
}
