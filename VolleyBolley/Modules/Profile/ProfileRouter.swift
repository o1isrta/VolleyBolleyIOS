import UIKit

protocol ProfileRouterProtocol: AnyObject {}

final class ProfileRouter: ProfileRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
