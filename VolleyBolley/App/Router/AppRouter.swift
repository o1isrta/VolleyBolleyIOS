//
//  AppRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

final class AppRouter {

    // MARK: - Private Properties

    private let window: UIWindow

    private let onboardingRepository: OnboardingRepositoryProtocol
    private let sessionRepository: SessionRepositoryProtocol

    private let onboardingRouter: OnboardingRouterProtocol
    private let authRouter: AuthRouterProtocol
    private let playerRegistrationRouter: UserRegRouterProtocol
    private let mainAppRouter: MainRouterProtocol

    // MARK: - Initializers

    init(
        window: UIWindow,
        onboardingRepository: OnboardingRepositoryProtocol,
        sessionRepository: SessionRepositoryProtocol,
        onboardingRouter: OnboardingRouterProtocol,
        authRouter: AuthRouterProtocol,
        playerRegistrationRouter: UserRegRouterProtocol,
        mainAppRouter: MainRouterProtocol
    ) {
        self.window = window
        self.onboardingRepository = onboardingRepository
        self.sessionRepository = sessionRepository
        self.onboardingRouter = onboardingRouter
        self.authRouter = authRouter
        self.playerRegistrationRouter = playerRegistrationRouter
        self.mainAppRouter = mainAppRouter
    }

    // MARK: - Public Methods

    func start() {
        if !onboardingRepository.isOnboardingShown {
            showOnboarding()
            return
        }

        guard let session = sessionRepository.currentSession else {
            showAuthorization()
            return
        }

        if session.isRegistered {
            showMainApp()
        } else {
            showPlayerRegistration()
        }
    }

    func resetToAuth() {
        showAuthorization()
    }

    // MARK: - Private Methods

    private func showOnboarding() {
        window.rootViewController = onboardingRouter.start()
        window.makeKeyAndVisible()
    }

    private func showAuthorization() {
        window.rootViewController = authRouter.start()
        window.makeKeyAndVisible()
    }

    private func showMainApp() {
        window.rootViewController = mainAppRouter.start()
        window.makeKeyAndVisible()
    }

    private func showPlayerRegistration() {
        window.rootViewController = playerRegistrationRouter.start()
        window.makeKeyAndVisible()
    }
}

// MARK: - OnboardingRouterDelegate

extension AppRouter: OnboardingRouterDelegate {
    func onboardingDidFinish() {
        start()
    }
}

// MARK: - AuthRouterDelegate

extension AppRouter: AuthRouterDelegate {
    func authDidFinish() {
        start()
    }
}

// MARK: - UserRegRouterDelegate

extension AppRouter: UserRegRouterDelegate {
    func registrationDidFinish() {
        showMainApp()
    }
}
