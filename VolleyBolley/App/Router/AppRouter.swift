//
//  AppRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

/// The `AppRouter` class is responsible for coordinating the root navigation flow of the application.
/// It determines which flow (onboarding, authentication, or main app) should be presented to the user
/// based on the current state of the user session. The class manages transitions between these flows
/// and ensures that the appropriate root view controller is set on the app's window.
/// 
/// - Responsibilities:
///   - Presents onboarding if the user has not completed it.
///   - Presents authentication if the user is not authorized.
///   - Presents the main app interface after onboarding and authentication are complete.
///   - Handles transitions between flows as the user's session state changes.
///   - Uses dependency injection (via Swinject) to resolve router dependencies for each flow.
/// 
/// - Usage:
///   - Initialize with a `UIWindow`, a `UserSessionServiceProtocol` instance, and a Swinject `Resolver`.
///   - Call `start()` to begin the root navigation flow.
/// 
/// - Note:
///   - This router should be created and started once, typically from the application delegate or main coordinator.
///   - Flow transitions are handled reactively when onboarding or authentication completes.
///   - The class maintains strong references to active sub-routers (onboarding and authentication) to keep them in memory.
///
/// - Dependencies:
///   - `UIWindow` for setting the root view controller.
///   - `UserSessionServiceProtocol` to determine session state.
///   - Swinject `Resolver` to resolve flow routers.
///
/// - SeeAlso: `OnboardingRouterProtocol`, `AuthRouterProtocol`, `MainAppRouterProtocol`
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

        authRouter = router
        window.rootViewController = router.start()
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
