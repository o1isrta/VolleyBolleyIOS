import Swinject
import UIKit

final class AppAssembly: Assembly {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func assemble(container: Container) {
        container.register(AppRouter.self) { resolver in
            guard let userSessionService = resolver.resolve(UserSessionServiceProtocol.self) else {
                fatalError("❌ Failed to resolve UserSessionServiceProtocol")
            }

            return AppRouter(
                window: self.window,
                userSessionService: userSessionService,
                resolver: resolver
            )
        }
        .inObjectScope(.container)
    }
}
