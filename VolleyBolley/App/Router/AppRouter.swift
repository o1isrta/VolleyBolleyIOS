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
        // TODO: Переписать через userSessionService
        if UserDefaults.standard.isOnboardingShown {
            showAuthorization()
        } else {
            showOnboarding()
        }
    }

    // MARK: - Private Methods

    private func showOnboarding() {
        guard let onboardingVC = resolver.resolve(OnboardingViewController.self) else {
            fatalError("OnboardingViewController не зарегистрирован")
        }
        let nav = UINavigationController(rootViewController: onboardingVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func showAuthorization() {
        guard let authVC = resolver.resolve(AuthViewController.self) else {
            fatalError("AuthViewController не зарегистрирован")
        }
        let nav = UINavigationController(rootViewController: authVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    private func showMainApp() {
        guard let router = resolver.resolve(MainAppRouterProtocol.self) else {
            print("Error: Failed to resolve MainAppRouterProtocol")
            return
        }

        let root = router.start()

        authRouter = nil
        onboardingRouter = nil

        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}
