//
//  BaseViewController.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

/// A base view controller providing common UI setup for all inheriting view controllers.
///
/// `BaseViewController` is designed to be subclassed by other view controllers in the app.
/// It sets the default background color and
/// configures the navigation bar to be hidden. Subclasses can override or extend these behaviors
/// as needed.
///
/// - Important: This class automatically hides the navigation bar
/// and sets the screen background color using `AppColor.Background.screen`.
///
/// - SeeAlso: `UIViewController`
class BaseViewController: UIViewController {

	// MARK: - Public Properties

	private lazy var navBar: CustomNavBarView = {
		return NavBarAssembly.createModule(with: self)
	}()

	// MARK: - Private Properties

	private let notificationManager = NotificationManager.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
		setupCustomNavigationBar()
		setupNotificationManager()
	}

	// MARK: - Public Methods

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		additionalSafeAreaInsets.top = 44
		view.bringSubviewToFront(navBar)
	}

	deinit {
		// Remove self from notification manager when deallocated
		notificationManager.removeDelegate(self)
	}
}

// MARK: - Private Methods

private extension BaseViewController {

	func setupCustomNavigationBar() {
		view.addSubviews(navBar)
		NSLayoutConstraint.activate([
			navBar.topAnchor.constraint(equalTo: view.topAnchor),
			navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}

	func setupNotificationManager() {
		// Register this BaseViewController with the notification manager
		notificationManager.addDelegate(self)
		// Get actual notifications status
		if !(self is NotificationsViewController) {
			let hasNewNotifications = notificationManager.hasNewNotifications()
			navBar.updateNotifications(hasNewNotifications)
		}
	}
}

// MARK: - NotificationManagerDelegate

extension BaseViewController: NotificationManagerDelegate {

	func notificationManager(_ manager: NotificationManager, didUpdateNotificationStatus hasNewNotifications: Bool) {
		// Check if the current view controller is NotificationsViewController
		// If it is, don't update navBar to avoid unnecessary UI changes
		if self is NotificationsViewController {
			return
		}
		// Update the navBar through the delegate method as requested
		navBar.updateNotifications(hasNewNotifications)
	}
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	BaseViewController()
}
#endif
