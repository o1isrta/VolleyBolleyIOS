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

	lazy var navBar: CustomNavBarView = {
		return NavBarAssembly.createModule(with: self)
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
		setupCustomNavigationBar()
		setupNotifications()
		// Notify navbar about view appearance for state synchronization
		navBar.viewWillAppear()
	}

	// MARK: - Public Methods

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// ALWAYS raise the navbar above all other subviews
		view.bringSubviewToFront(navBar)
	}
}

// MARK: - Private Methods

private extension BaseViewController {

	func setupNotifications() {
		// This ensures state synchronization when navigating between tabs
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(handleNewNotification(_:)),
			name: NotificationConstants.NavBar.newNotificationArrived,
			object: nil
		)
	}

	@objc func handleNewNotification(_ notification: Notification) {
		guard let userInfo = notification.userInfo else { return }

		if let navBarNotification = NavBarNotification(userInfo: userInfo) {
			navBar.updateNotifications(navBarNotification.isArrived)
		}
	}

	func setupCustomNavigationBar() {
		view.addSubviews(navBar)
		NSLayoutConstraint.activate([
			navBar.topAnchor.constraint(equalTo: view.topAnchor),
			navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	BaseViewController()
}
#endif
