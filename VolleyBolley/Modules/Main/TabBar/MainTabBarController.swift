//
//  MainTabBarController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class MainTabBarController: UIViewController {

	// MARK: - Private Properties

	private var currentTab: TabBarItem = .home

	private let notificationManager = NotificationManager.shared

	// MARK: - UI Components

	private var viewControllers: [TabBarItem: UIViewController] = [:]

	private lazy var containerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private lazy var tabBar: MainTabBarView = {
		let view = MainTabBarView(items: TabBarItem.allCases)
		view.delegate = self
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupLayout()
		setupChildViewControllers()
		setupNotificationService()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		additionalSafeAreaInsets.bottom = 48
	}

	func setViewControllers(_ viewControllers: [TabBarItem: UIViewController]) {
		for child in children {
			child.willMove(toParent: nil)
			child.view.removeFromSuperview()
			child.removeFromParent()
		}
		self.viewControllers = viewControllers
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
		notificationManager.stopService()
	}

	// MARK: - Setup

	private func setupView() {
		view.addSubview(containerView)
		view.addSubview(tabBar)
	}

	private func setupNotificationService() {
		// Start the notification manager service
		notificationManager.startService()
		// Setup app lifecycle observers for the service
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(appDidEnterBackground),
			name: UIApplication.didEnterBackgroundNotification,
			object: nil
		)

		NotificationCenter.default.addObserver(
			self,
			selector: #selector(appWillEnterForeground),
			name: UIApplication.willEnterForegroundNotification,
			object: nil
		)
	}

	private func setupChildViewControllers() {
		for (tab, viewController) in viewControllers {
			addChild(viewController)
			containerView.addSubview(viewController.view)
			viewController.view.translatesAutoresizingMaskIntoConstraints = false
			setupConstraintsForChild(viewController)
			viewController.didMove(toParent: self)
			viewController.view.isHidden = (tab != currentTab)
		}
	}

	// MARK: - Navigation

	private func switchToViewController(at tab: TabBarItem) {
		guard let selectedVC = viewControllers[tab] else { return }
		let previousVC = viewControllers[currentTab]
		// Check if we're switching away from a tab that has NotificationsViewController presented
		handleNotificationsViewControllerOnTabSwitch(previousVC: previousVC)

		previousVC?.view.isHidden = true
		selectedVC.view.isHidden = false

		currentTab = tab
		tabBar.updateSelection(index: tab.rawValue)
	}

	// MARK: - Layout setup

	private func setupLayout() {
		setupConstraintsContainerView()
		setupConstraintsTabBar()
	}

	// MARK: - Constraints

	private func setupConstraintsTabBar() {
		NSLayoutConstraint.activate([
			tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tabBar.heightAnchor.constraint(equalToConstant: 81)
		])
	}

	private func setupConstraintsContainerView() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: view.topAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}

	private func setupConstraintsForChild(_ selectedVC: UIViewController) {
		NSLayoutConstraint.activate([
			selectedVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
			selectedVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			selectedVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			selectedVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
	}
}

// MARK: - App Lifecycle

private extension MainTabBarController {

	// MARK: - NotificationsViewController Handling

	func handleNotificationsViewControllerOnTabSwitch(previousVC: UIViewController?) {
		guard let previousVC else { return }
		// Check if NotificationsViewController is presented from the previous tab
		if let notificationsVC = findNotificationsViewController(in: previousVC) {
			// Call presenter?.viewDidDisappear() when switching away from the tab
			notificationsVC.presenter?.viewDidDisappear()
		}
	}

	func findNotificationsViewController(in viewController: UIViewController) -> NotificationsViewController? {
		// Check if the view controller itself is NotificationsViewController
		if let notificationsVC = viewController as? NotificationsViewController {
			return notificationsVC
		}
		// Check navigation stack if view controller has navigation controller
		if let navigationController = viewController as? UINavigationController {
			for navigationVC in navigationController.viewControllers {
				if let notificationsVC = navigationVC as? NotificationsViewController {
					return notificationsVC
				}
			}
		}
		// Check if NotificationsViewController is presented modally
		if let presentedVC = viewController.presentedViewController {
			if let notificationsVC = presentedVC as? NotificationsViewController {
				return notificationsVC
			}
			// Recursively check presented view controllers
			return findNotificationsViewController(in: presentedVC)
		}
		// Check child view controllers
		for childVC in viewController.children {
			if let notificationsVC = findNotificationsViewController(in: childVC) {
				return notificationsVC
			}
		}

		return nil
	}

	@objc func appDidEnterBackground() {
		notificationManager.stopService()
	}

	@objc func appWillEnterForeground() {
		notificationManager.startService()
	}
}

// MARK: - MainTabBarViewDelegate

extension MainTabBarController: MainTabBarViewDelegate {
	func customTabBarView(_ tabBarView: MainTabBarView, didSelectItemAt index: Int) {
		guard let item = TabBarItem(rawValue: index) else { return }
		switchToViewController(at: item)
	}
}
