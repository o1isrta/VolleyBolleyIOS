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

    private var navigationController: UINavigationController?

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
        navigationController = nav
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    private func showAuthorization() {
        guard let authVC = resolver.resolve(AuthViewController.self) else {
            fatalError("AuthViewController не зарегистрирован")
        }
        let nav = UINavigationController(rootViewController: authVC)
        navigationController = nav
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func pushPhoneAuth() {
        guard let nav = navigationController,
              let phoneAuthVC = resolver.resolve(PhoneAuthViewController.self) else { return }
        nav.pushViewController(phoneAuthVC, animated: true)
    }

    func pushPhoneVerify(phoneNumber: String) {
        guard let nav = navigationController,
              let phoneVerifyVC = resolver.resolve(PhoneVerifyViewController.self, argument: phoneNumber) else { return }
        nav.pushViewController(phoneVerifyVC, animated: true)
    }

    func pushUserReg() {
        guard let nav = navigationController,
              let userRegVC = resolver.resolve(UserRegViewController.self) else { return }
        nav.pushViewController(userRegVC, animated: true)
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
