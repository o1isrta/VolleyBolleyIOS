import UIKit

protocol MyGamesRouterProtocol: AnyObject {}

final class MyGamesRouter: MyGamesRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
