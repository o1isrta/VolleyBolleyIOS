import Swinject
import UIKit

protocol OnboardingRouterProtocol {
    var onFinish: (() -> Void)? { get set }
    func start() -> UIViewController
}

final class OnboardingRouter: OnboardingRouterProtocol {
    var onFinish: (() -> Void)?
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func start() -> UIViewController {
        guard let viewController = resolver.resolve(OnboardingViewController.self) else {
            fatalError("❌ Failed to resolve AuthViewController")
        }

        viewController.onContinue = { [weak self] in
            self?.onFinish?()
        }

        return viewController
    }
}
