import Swinject
import UIKit

/// `AppAssembly` is a Swinject `Assembly` responsible for registering and configuring
/// the application's main router and its dependencies.
///
/// This class primarily registers the `AppRouter` in the dependency injection container,
/// ensuring that it is constructed with the main `UIWindow`, an instance conforming to
/// `UserSessionServiceProtocol`, and the resolver for further dependencies.
///
/// - Note: The assembly expects to be initialized with the application's main window.
/// - Warning: If `UserSessionServiceProtocol` cannot be resolved, the app will terminate
///            with a fatal error indicating the missing dependency.
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
