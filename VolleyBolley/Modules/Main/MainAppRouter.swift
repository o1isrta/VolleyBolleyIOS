import Swinject
import UIKit

protocol MainAppRouterProtocol {
    func start() -> UIViewController
}

final class MainAppRouter: MainAppRouterProtocol {
    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() -> UIViewController {
        return MainTabBarController()
    }
}
