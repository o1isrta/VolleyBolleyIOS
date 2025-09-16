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

	let navBar = CustomNavBarView()
	let tabBar = MainTabBarController()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
		setupCustomNavigationBar()
		setupCustomTabBar()
	}

	// MARK: - Public Methods

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// ALWAYS raise the navbar/tabBar above all other subviews
		view.bringSubviewToFront(navBar)
		view.bringSubviewToFront(tabBar.view)
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

	func setupCustomTabBar() {
		view.addSubviews(tabBar.view)
		NSLayoutConstraint.activate([
			tabBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tabBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tabBar.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	BaseViewController()
}
#endif
