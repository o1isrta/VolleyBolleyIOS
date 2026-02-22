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
		let environment = resolver.safeResolve(AppEnvironment.self)

		if !userSessionService.isOnboardingShown {
			showOnboarding()
			return
		}

		switch environment {
		// TODO: - change to showAuthorization() when user registration is ready
		case .staging, .mock: showMainApp()
		case .production: showAuthorization()
		}
	}

	func showMainApp() {
		let router = resolver.safeResolve(MainAppRouterProtocol.self)
		let root = router.start()

		authRouter = nil
		onboardingRouter = nil

		window.rootViewController = root
		window.makeKeyAndVisible()
	}

	func showAuthorization() {
		let authVC = resolver.safeResolve(AuthViewController.self)
		let nav = UINavigationController(rootViewController: authVC)
		navigationController = nav
		window.rootViewController = nav
		window.makeKeyAndVisible()
	}

	// MARK: - Private Methods

	private func showOnboarding() {
		let onboardingVC = resolver.safeResolve(OnboardingViewController.self)
		let nav = UINavigationController(rootViewController: onboardingVC)
		navigationController = nav
		window.rootViewController = nav
		window.makeKeyAndVisible()
	}

	func pushPhoneAuth() {
		guard let nav = navigationController else { return }
		let phoneAuthVC = resolver.safeResolve(PhoneAuthViewController.self)
		nav.pushViewController(phoneAuthVC, animated: true)
	}

	func pushPhoneVerify(phoneNumber: String) {
		guard let nav = navigationController,
			  let phoneVerifyVC = resolver.resolve(
				PhoneVerifyViewController.self,
				argument: phoneNumber
			  ) else {
			return
		}
		nav.pushViewController(phoneVerifyVC, animated: true)
	}

	func pushRegistration() {
		guard let nav = navigationController else { return }
		let userRegVC = resolver.safeResolve(RegistrationViewController.self)
		nav.pushViewController(userRegVC, animated: true)
	}
}
