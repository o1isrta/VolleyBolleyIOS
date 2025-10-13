//
//  NotificationService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.09.2025.
//

import Foundation

// MARK: - NotificationServiceDelegate

protocol NotificationServiceDelegate: AnyObject {
	func notificationService(
		_ service: NotificationService,
		didUpdateNotificationStatus hasNewNotifications: Bool
	)
	func notificationService(
		_ service: NotificationService,
		didReceiveNotifications notifications: [NotificationCardViewModel]
	)
}

// MARK: - NotificationService

final class NotificationService {

	// MARK: - Public Properties

	weak var delegate: NotificationServiceDelegate?

	/// Indicates whether there are new notifications that haven't been viewed by the user.
	///
	/// ## Purpose:
	/// - Tracks the read/unread state of notifications in the application
	/// - Used to show badge indicators or highlight notification sections
	/// - Persists between app launches to maintain state
	///
	/// ## Behavior:
	/// - `true`: There are new, unread notifications available
	/// - `false`: All notifications have been read or there are no notifications
	///
	/// ## Storage:
	/// - Automatically persisted in UserDefaults under key "hasNewNotifications"
	/// - Survives application termination and restart
	/// - Synchronized across app sessions
	///
	/// ## Usage:
	/// ```swift
	/// // Check if there are new notifications
	/// if notificationsManager.hasNewNotifications {
	///     showNotificationBadge()
	/// }
	///
	/// // Mark as having new notifications
	/// notificationsManager.hasNewNotifications = true
	///
	/// // Mark all as read
	/// notificationsManager.hasNewNotifications = false
	/// ```
	@UserDefaultsCodable(
		key: AppConstants.UserDefaults.Keys.hasNewNotifications,
		defaultValue: false
	)
	private(set) var hasNewNotifications: Bool

	/// Array of current notifications with automatic saving to UserDefaults.
	///
	/// ## Features:
	/// - Maximum capacity: 100 notifications by defaults
	/// - Data is preserved between app launches
	/// - Old notifications are automatically removed when limit is exceeded
	@LimitedUserDefaultsArray(key: AppConstants.UserDefaults.Keys.currentNotifications)
	private(set) var currentNotifications: [NotificationCardViewModel]

	// MARK: - Private Properties

	private var timer: Timer?
	private let checkInterval: TimeInterval = AppConstants.Notifications.checkInterval
	private var isActive: Bool = false

	// MARK: - Singleton

	static let shared = NotificationService()

	private init() {}

	// MARK: - Public Methods

	/// Started periodic notification checking (every N minutes)
	func startPeriodicCheck() {
		guard !isActive else { return }

		isActive = true
		// Perform initial check
		checkNotifications()
		// Schedule periodic checks
		timer = Timer.scheduledTimer(withTimeInterval: checkInterval, repeats: true) { [weak self] _ in
			self?.checkNotifications()
		}
	}

	/// Stopped periodic notification checking
	func stopPeriodicCheck() {
		timer?.invalidate()
		timer = nil
		isActive = false
	}

	func checkNotifications() {
		// Simulate network request
		// TODO: need real network request
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			guard let self else { return }
			// Getting notifications from server
			let newNotifications = self.fetchNotificationsFromServer()
			// Check if there are new notifications
			let hasNew = !self.currentNotifications.contains(newNotifications)
			// Update state
			if hasNew {
				self.addNotifications(newNotifications)
			}
			self.hasNewNotifications = hasNew
			// Always notify delegate about notifications data (for screen updates)
			self.delegate?.notificationService(self, didReceiveNotifications: self.currentNotifications)
			self.delegate?.notificationService(self, didUpdateNotificationStatus: hasNew)
		}
	}

	func markNotificationsAsRead() {
		guard hasNewNotifications else { return }
		hasNewNotifications = false
		delegate?.notificationService(self, didUpdateNotificationStatus: hasNewNotifications)
	}

	/// Removes a specific notification from the list.
	///
	/// - Parameter notification: Notification to remove
	///
	/// ## Note:
	/// Notifications are compared using Equatable protocol
	///
	/// ## Example:
	/// ```swift
	/// manager.removeNotification(notification)
	/// ```
	func removeNotification(_ notification: NotificationCardViewModel) {
		currentNotifications = currentNotifications.filter { $0 != notification }
	}

	/// Completely clears the notifications list.
	///
	/// ## Example:
	/// ```swift
	/// manager.clearAllNotifications()
	/// ```
	func clearAllNotifications() {
		currentNotifications = []
	}

	deinit {
		stopPeriodicCheck()
	}
}

// MARK: - Private Methods

private extension NotificationService {

	/// Adds multiple notifications to the beginning of the list.
	///
	/// - Parameter notifications: Array of notifications to add
	///
	/// ## Note:
	/// The order of notifications in the passed array is preserved when adding
	///
	/// ## Example:
	/// ```swift
	/// let notifications = [notification1, notification2, notification3]
	/// manager.addNotifications(notifications)
	/// ```
	func addNotifications(_ notifications: [NotificationCardViewModel]) {
		var allNotifications = currentNotifications
		// Add to the beginning of the array (preserving order)
		allNotifications.insert(contentsOf: notifications, at: 0)
		currentNotifications = allNotifications
	}

	func fetchNotificationsFromServer() -> [NotificationCardViewModel] {
		// TODO: - simulate a network request
		var notifications: [NotificationCardViewModel] = []
		// Simulate new notifications occasionally
		let mockNotification = NotificationCardViewModel.mockDataArray.randomElement()!
		let newNotification = NotificationCardViewModel(
			title: mockNotification.title,
			message: mockNotification.message + " (Received at \(Date().formatted(date: .omitted, time: .complete))",
			date: Date()
		)
		notifications.append(newNotification)

		return notifications
	}
}

// MARK: - App Lifecycle Integration

extension NotificationService {

	/// Stopping checks to save battery when App entered background
	func handleAppDidEnterBackground() {
		stopPeriodicCheck()
	}

	/// Resuming checks when app comes back
	func handleAppWillEnterForeground() {
		startPeriodicCheck()
	}
}
