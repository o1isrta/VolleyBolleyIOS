import Swinject
import UIKit

final class DIContainer {

    private static var _shared: DIContainer?

    static func initialize(window: UIWindow) {
        precondition(_shared == nil, "DIContainer already initialized")
        _shared = DIContainer(window: window)
    }

    static var shared: DIContainer {
        guard let instance = _shared else {
            fatalError("DIContainer.shared accessed before being initialized. Call DIContainer.initialize(window:) first.")
        }
        return instance
    }

    let assembler: Assembler
    var resolver: Resolver { assembler.resolver }

    init(window: UIWindow) {
        assembler = Assembler(
            [
                SharedServicesAssembly(),
                AppAssembly(window: window),
                OnboardingAssembly(),
                AuthAssembly(),
                MainAssembly(),
                HomeAssembly(),
                MyGamesAssembly(),
                ProfileAssembly()
            ]
        )
    }
}
