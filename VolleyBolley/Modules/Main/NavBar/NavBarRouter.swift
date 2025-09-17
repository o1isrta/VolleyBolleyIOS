//
//  NavBarRouter.swift
//  VolleyBolley
//
//  Created by Qoder on 16.09.2025.
//

import UIKit

protocol NavBarRouterProtocol: AnyObject {
	var viewController: UIViewController? { get set }

	func showNotifications(with notifications: [NotificationCardViewModel])
	func updateNotificationsVC(with notifications: [NotificationCardViewModel])
}

final class NavBarRouter: NavBarRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?

	// MARK: - Public Methods

	func showNotifications(with notifications: [NotificationCardViewModel]) {
		guard let viewController else { return }
		// Check if NotificationsViewController is already presented
		if isNotificationsViewControllerPresented() {
			return // Don't open another instance
		}
		// Create the notifications module using its assembly with provided data
		let notificationsViewController = NotificationsAssembly.createModule(with: notifications)
		// Navigate to notifications screen
		if let navigationController = viewController.navigationController {
			navigationController.pushViewController(notificationsViewController, animated: true)
		} else {
			// If there's no navigation controller, present modally
			notificationsViewController.modalPresentationStyle = .fullScreen
			viewController.present(notificationsViewController, animated: true)
		}
	}

	func updateNotificationsVC(with notifications: [NotificationCardViewModel]) {
		guard let viewController else { return }
		if let notificationsVC = viewController
			.navigationController?
			.viewControllers
			.first(
				where: {
					$0 is NotificationsViewControllerProtocol
				}) as? NotificationsViewControllerProtocol {
			print("notificationsVC.presenter?.viewDidLoad()")// TODO: - Notifications
			notificationsVC.displayNotifications(notifications)
		}
	}

	// MARK: - Private Methods

	private func isNotificationsViewControllerPresented() -> Bool {
		guard let viewController else { return false }
		// Check navigation stack
		if let navigationController = viewController.navigationController {
			return navigationController.viewControllers.contains { $0 is NotificationsViewController }
		}
		// Check if modally presented
		return viewController.presentedViewController is NotificationsViewController
	}
}
