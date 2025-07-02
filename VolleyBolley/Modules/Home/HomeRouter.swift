import UIKit

protocol HomeRouterProtocol: AnyObject {}

final class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
