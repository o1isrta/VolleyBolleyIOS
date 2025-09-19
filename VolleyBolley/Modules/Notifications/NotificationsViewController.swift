//
//  NotificationsViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import UIKit

protocol NotificationsViewControllerProtocol: AnyObject {
	var presenter: NotificationsPresenterProtocol? { get }
	func displayNotifications(_ notifications: [NotificationCardViewModel])
	func displayEmptyState()
}

final class NotificationsViewController: BaseViewController {

    // MARK: - Public Properties

    var presenter: NotificationsPresenterProtocol?

	// MARK: - Private Properties

	private var notifications: [NotificationCardViewModel] = []

	private lazy var glassmorphismView = GlassmorphismView()
	private lazy var screenTitle = CustomTitle(text: String(localized: "notifications.screenTitle"), isLarge: true)
	private lazy var backButton: UtilityButton = {
		let button = UtilityButton(style: .small)
		button.setImage(.chevronBackward, for: .normal)
		button.tintColor = AppColor.Icon.primary
		button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		return button
	}()
	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableViewContentSizeObserver: NSKeyValueObservation?
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = AppColor.Background.clear
		tableView.separatorStyle = .none
		tableView.rowHeight = UITableView.automaticDimension
		tableView.dataSource = self
		tableView.showsVerticalScrollIndicator = false
		tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.reuseIdentifier)
		return tableView
	}()

	// MARK: - Public Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupTableViewContentSizeObserver()
        presenter?.viewDidLoad()
		setupNotificationObservers()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navBar.updateNotifications(false)
	}
}

// MARK: - Private Methods

private extension NotificationsViewController {

	@objc func backButtonTapped() {
		presenter?.backButtonTapped()
	}

	func setupUI() {
		view.addSubviews(
			glassmorphismView,
			backButton,
			screenTitle,
			tableView
		)

		let mainIndent: CGFloat = 8
		let mainSpacing: CGFloat = 20

		NSLayoutConstraint.activate([
			glassmorphismView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: mainIndent),
			glassmorphismView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: mainIndent),
			glassmorphismView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -mainIndent),
			glassmorphismView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: mainIndent),

			backButton.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: 14),
			backButton.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing / 2),

			screenTitle.centerXAnchor.constraint(equalTo: glassmorphismView.centerXAnchor),
			screenTitle.topAnchor.constraint(equalTo: glassmorphismView.topAnchor, constant: mainSpacing),

			tableView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 12),
			tableView.leadingAnchor.constraint(equalTo: glassmorphismView.leadingAnchor, constant: mainSpacing),
			tableView.trailingAnchor.constraint(equalTo: glassmorphismView.trailingAnchor, constant: -mainSpacing)
		])

		tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
		tableViewHeightConstraint?.isActive = true
	}

	func setupNotificationObservers() {
		let notification = NavBarNotification(isArrived: false)
		NotificationCenter.default.post(
			name: NotificationConstants.NavBar.newNotificationArrived,
			object: self,
			userInfo: notification.userInfo
		)
	}

	func setupTableViewContentSizeObserver() {
		tableViewContentSizeObserver = tableView.observe(
			\.contentSize,
			 options: [.new]
		) { [weak self] _, change in
			guard
				let self,
				let newSize = change.newValue
			else { return }
			// Limiting the max height to preserve scrolling
			let maxHeight = UIScreen.main.bounds.height - 268
			let newHeight = min(newSize.height, maxHeight)
			self.tableViewHeightConstraint?.constant = newHeight
		}
	}
}

// MARK: - NotificationsViewControllerProtocol

extension NotificationsViewController: NotificationsViewControllerProtocol {

	func displayNotifications(_ notifications: [NotificationCardViewModel]) {
		self.notifications = notifications
		navBar.updateNotifications(false)
		tableView.reloadData()
	}

	func displayEmptyState() {
		self.notifications = []
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension NotificationsViewController: UITableViewDataSource {

	func getRowsCount() -> Int {
		if notifications.count == 0 {
			return 1
		}

		return notifications.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		getRowsCount()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(
			withIdentifier: NotificationCell.reuseIdentifier,
			for: indexPath
		) as? NotificationCell {
			if notifications.count == 0 {
				cell.configureAsNoNotifications()
			} else {
				let item = notifications[indexPath.row]
				cell.configure(with: item)
			}
			return cell
		}

		return UITableViewCell()
	}
}

// MARK: - Preview

#if DEBUG
@available(iOS 17.0, *)
#Preview("No") {
	NotificationsAssembly.createModule(with: [])
}
@available(iOS 17.0, *)
#Preview("Several") {
	let model = NotificationCardViewModel.mockDataArray
	NotificationsAssembly.createModule(with: model)
}
@available(iOS 17.0, *)
#Preview("Multiple") {
	let model = Array(
		repeating: NotificationCardViewModel.mockDataArray,
		count: 7
	).flatMap { $0 }
	NotificationsAssembly.createModule(with: model)
}
#endif
