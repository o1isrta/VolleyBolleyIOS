#if DEBUG
import UIKit

final class MockHomeRouter: HomeRouterProtocol {

    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }
}
#endif
