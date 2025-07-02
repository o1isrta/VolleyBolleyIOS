import Foundation
import Swinject

class MainAssembly: Assembly {
    private weak var appRouter: AppRouter?

    init(appRouter: AppRouter? = nil) {
        self.appRouter = appRouter
    }

    func assemble(container: Container) {
        container.register(MainAppRouterProtocol.self) { _ in
            MainAppRouter(container: container)
        }
    }
}
