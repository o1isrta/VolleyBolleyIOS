import Swinject
import UIKit

protocol AuthRouterProtocol {
    var onLoginSuccess: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class AuthRouter: AuthRouterProtocol {
    var onLoginSuccess: (() -> Void)?
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func start() -> UIViewController {
        guard let viewController = resolver.resolve(AuthViewController.self) else {
            fatalError("❌ Failed to resolve AuthViewController")
        }

        // Можно внедрить presenter через resolver при необходимости
        viewController.onLogin = { [weak self] in
            self?.onLoginSuccess?()
        }

        return UINavigationController(rootViewController: viewController)
    }
}
