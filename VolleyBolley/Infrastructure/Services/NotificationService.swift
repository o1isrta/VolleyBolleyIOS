//
//  NotificationService.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.09.2025.
//

import Foundation
import UIKit

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
	private(set) var hasNewNotifications: Bool = false
	private(set) var currentNotifications: [NotificationCardViewModel] = []

	// MARK: - Private Properties

	private var timer: Timer?
	private let checkInterval: TimeInterval = 10 // 300 - 5 minutes // TODO: -
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
		print("NotificationService: Checking for new notifications...")// TODO: -
		// Simulate network request
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			guard let self else { return }
			// Getting notifications from server
			let newNotifications = self.fetchNotificationsFromServer()
			// Check if there are new notifications
			let hasNew = !self.currentNotifications.contains(newNotifications)
			// Update state
			if hasNew {
				self.currentNotifications.append(contentsOf: newNotifications)
			}
			self.hasNewNotifications = hasNew
			// Always notify delegate about notifications data (for screen updates)
			self.delegate?.notificationService(self, didReceiveNotifications: self.currentNotifications)
			self.delegate?.notificationService(self, didUpdateNotificationStatus: hasNew)
			print("NotificationService: Notification status changed to: \(hasNew)")// TODO: -
		}
	}

	func markNotificationsAsRead() {
		guard hasNewNotifications else { return }
		hasNewNotifications = false
		delegate?.notificationService(self, didUpdateNotificationStatus: false)
	}

	// MARK: - Private Methods

	private func fetchNotificationsFromServer() -> [NotificationCardViewModel] {
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

	deinit {
		stopPeriodicCheck()
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
