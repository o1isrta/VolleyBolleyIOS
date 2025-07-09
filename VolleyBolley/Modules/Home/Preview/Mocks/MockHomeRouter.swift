#if DEBUG
import UIKit

final class MockHomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?

    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
}
#endif
