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

	private(set) lazy var customNavBar: CustomNavBarView = {
		return NavBarAssembly.createModule(with: self)
	}()

	// MARK: - Private Properties

	private let notificationManager = NotificationManager.shared

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.Background.navBar
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = true
        return view
    }()

    // MARK: - Initializers

    deinit {
        notificationManager.removeDelegate(self)
    }

    // MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = AppColor.Background.screen
        setupSystemNavBarAppearance()
		setupNotificationManager()
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        embedViews()
    }
}

// MARK: - Private Methods

private extension BaseViewController {

    private func setupSystemNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]

        navigationItem.backButtonTitle = ""
        navigationItem.title = ""

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        navigationController?.navigationBar.tintColor = .clear
    }

	func setupNotificationManager() {
		notificationManager.addDelegate(self)

		if !(self is NotificationsViewController) {
			let hasNewNotifications = notificationManager.hasNewNotifications()
            customNavBar.updateNotifications(hasNewNotifications)
		}
	}

    func embedViews() {
        guard let navBar = navigationController?.navigationBar else { return }

        navBar.addSubviews(backgroundView, customNavBar)

        setupConstraintsBackgroundView(navBar: navBar)
        setupConstraintsCustomNavBar(navBar: navBar)
    }

    func setupConstraintsBackgroundView(navBar: UINavigationBar) {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor)
        ])
    }

    func setupConstraintsCustomNavBar(navBar: UINavigationBar) {
        NSLayoutConstraint.activate([
            customNavBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 8),
            customNavBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -8),
            customNavBar.topAnchor.constraint(equalTo: navBar.topAnchor),
            customNavBar.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - NotificationManagerDelegate

extension BaseViewController: NotificationManagerDelegate {

	func notificationManager(_ manager: NotificationManager, didUpdateNotificationStatus hasNewNotifications: Bool) {
		if self is NotificationsViewController {
			return
		}

        customNavBar.updateNotifications(hasNewNotifications)
	}
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
	BaseViewController()
}
#endif
