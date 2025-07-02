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
        let tabBarController = UITabBarController()

        let home = HomeAssembly.assemble()
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let games = MyGamesAssembly.assemble()
        games.tabBarItem = UITabBarItem(title: "My Games", image: UIImage(systemName: "gamecontroller.fill"), tag: 1)

        let profile = ProfileAssembly.assemble()
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: home),
            UINavigationController(rootViewController: games),
            UINavigationController(rootViewController: profile)
        ]
        return tabBarController
    }
}
