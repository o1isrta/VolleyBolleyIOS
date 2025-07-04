import Swinject
import UIKit

protocol AuthRouterProtocol {
    var onLoginSuccess: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class AuthRouter: AuthRouterProtocol {
    var onLoginSuccess: (() -> Void)?
    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() -> UIViewController {
        let viewController = AuthViewController()

        viewController.onLogin = { [weak self] in
            self?.onLoginSuccess?()
        }

        return UINavigationController(rootViewController: viewController)
    }
}
