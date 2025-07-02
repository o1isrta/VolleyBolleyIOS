import Swinject
import UIKit

protocol OnboardingRouterProtocol {
    var onFinish: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class OnboardingRouter: OnboardingRouterProtocol {
    var onFinish: (() -> Void)?
    private let container: Container

    init(container: Container) {
        self.container = container
    }

    func start() -> UIViewController {
        let viewController = OnboardingViewController()
        
        viewController.onContinue = { [weak self] in
            self?.onFinish?()
        }

        return viewController
    }
}
