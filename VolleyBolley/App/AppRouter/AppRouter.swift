import Swinject
import UIKit

final class AppRouter {
    private let window: UIWindow
    private let assembler: Assembler
    private let userSessionService: UserSessionServiceProtocol
    private var onboardingRouter: OnboardingRouterProtocol?
    private var authRouter: AuthRouterProtocol?

    init(window: UIWindow, assembler: Assembler) {
        self.window = window
        self.assembler = assembler
        guard
            let sessionService = assembler.resolver.resolve(UserSessionServiceProtocol.self)
        else {
            fatalError("Error: Failed to resolve UserSessionServiceProtocol")
        }

        self.userSessionService = sessionService
    }

    func start() {
        if !userSessionService.isOnboardingShown {
            showOnboarding()
        } else if !userSessionService.isAuthorized {
            showAuth()
        } else {
            showMainApp()
        }
    }

    private func showOnboarding() {
        guard
            var router = assembler.resolver.resolve(OnboardingRouterProtocol.self)
        else {
            print("Error: Failed to resolve OnboardingRouterProtocol")
            return
        }

        router.onFinish = { [weak self] in
            guard let self = self else { return }

            self.userSessionService.markOnboardingAsShown()
            self.start()
        }

        onboardingRouter = router
        window.rootViewController = router.start()
    }

    private func showAuth() {
        guard
            var router = assembler.resolver.resolve(AuthRouterProtocol.self)
        else {
            print("Error: Failed to resolve AuthRouterProtocol")
            return
        }

        router.onLoginSuccess = { [weak self] in
            guard let self = self else { return }

            self.userSessionService.markUserAuthorized()
            self.start()
        }

        self.authRouter = router
        window.rootViewController = router.start()
    }

    private func showMainApp() {
        guard
            let router = assembler.resolver.resolve(MainAppRouterProtocol.self)
        else {
            print("Error: Failed to resolve MainAppRouterProtocol")
            return
        }

        let root = router.start()

        self.authRouter = nil
        self.onboardingRouter = nil

        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}
