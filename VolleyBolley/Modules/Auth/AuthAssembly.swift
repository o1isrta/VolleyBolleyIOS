import Foundation
import Swinject

class AuthAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthRouterProtocol.self) { _ in
            AuthRouter(container: container)
        }
    }
}
