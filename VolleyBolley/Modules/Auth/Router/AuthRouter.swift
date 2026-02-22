//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import AuthenticationServices
import UIKit

protocol AuthRouterProtocol: AnyObject, PresentationContextProvider {
	var delegate: AuthRouterDelegate? { get set }
	var presentingViewController: UIViewController { get }
	func start() -> UIViewController
	func finishAuth()
}

protocol AuthRouterDelegate: AnyObject {
	func authDidFinish()
}

final class AuthRouter: NSObject, AuthRouterProtocol {

	// MARK: - Public Properties

	weak var delegate: AuthRouterDelegate?

	var presentingViewController: UIViewController {
		guard
			let nav = window.rootViewController as? UINavigationController,
			let topVC = nav.topViewController
		else {
			fatalError("❌ Не удалось найти presentingViewController для GoogleAuth")
		}

		return topVC
	}

	// MARK: - Private Properties

	private let window: UIWindow
	private let viewControllerFactory: () -> UIViewController
	private let userRegFactory: () -> UIViewController

	private weak var navigationController: UINavigationController?

	// MARK: - Initializers

	init(
		window: UIWindow,
		viewControllerFactory: @escaping () -> UIViewController,
		userRegFactory: @escaping () -> UIViewController
	) {
		self.window = window
		self.viewControllerFactory = viewControllerFactory
		self.userRegFactory = userRegFactory
	}

	// MARK: - Public Methods

	func start() -> UIViewController {
		let rootVC = viewControllerFactory()
		let nav = UINavigationController(rootViewController: rootVC)
		navigationController = nav
		return nav
	}

	func finishAuth() {
		delegate?.authDidFinish()
	}
}
