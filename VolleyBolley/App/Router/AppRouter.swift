//
//  AppRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

final class AppRouter {

    // MARK: - Private Properties

    private let window: UIWindow
    private let userSessionService: UserSessionServiceProtocol
    private let resolver: Resolver

    private var onboardingRouter: OnboardingRouterProtocol?
    private var authRouter: AuthRouterProtocol?

    // MARK: - Initializers

    init(
        window: UIWindow,
        userSessionService: UserSessionServiceProtocol,
        resolver: Resolver
    ) {
        self.window = window
        self.userSessionService = userSessionService
        self.resolver = resolver
    }

    // MARK: - Public Methods

    func start() {
        if !userSessionService.isOnboardingShown {
            showOnboarding()
        } else if !userSessionService.isAuthorized {
            showAuth()
        } else {
            showMainApp()
        }
    }

    // MARK: - Private Methods

    private func showOnboarding() {
        guard var router = resolver.resolve(OnboardingRouterProtocol.self) else {
            print("Error: Failed to resolve OnboardingRouterProtocol")
            return
        }

        router.onFinish = { [weak self] in
            guard let self else { return }

            self.userSessionService.markOnboardingAsShown()
            self.start()
        }

        onboardingRouter = router
        window.rootViewController = router.start()
    }

    private func showAuth() {
        guard var router = resolver.resolve(AuthRouterProtocol.self) else {
            print("Error: Failed to resolve AuthRouterProtocol")
            return
        }

        router.onLoginSuccess = { [weak self] in
            guard let self else { return }

            self.userSessionService.markUserAuthorized()
            self.start()
        }

        self.authRouter = router
        window.rootViewController = router.start()
    }

    private func showMainApp() {
        guard let router = resolver.resolve(MainAppRouterProtocol.self) else {
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
