//
//  NotificationManager.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.09.2025.
//

import Foundation
import UIKit

// MARK: - NotificationManagerDelegate

protocol NotificationManagerDelegate: AnyObject {
	func notificationManager(
		_ manager: NotificationManager,
		didUpdateNotificationStatus hasNewNotifications: Bool
	)
}

// MARK: - NotificationDataUpdateDelegate

protocol NotificationDataUpdateDelegate: AnyObject {
	func notificationManager(
		_ manager: NotificationManager,
		didReceiveNotifications notifications: [NotificationCardViewModel]
	)
}

// MARK: - NotificationManager

final class NotificationManager {

	// MARK: - Singleton

	static let shared = NotificationManager()

	// MARK: - Private Properties

	private var delegates: [WeakDelegate] = []
	private var dataUpdateDelegates: [WeakDataUpdateDelegate] = []
	private let notificationService = NotificationService.shared

	// MARK: - Private Initialization

	private init() {
		setupService()
	}

	// MARK: - Public Methods

	func addDelegate(_ delegate: NotificationManagerDelegate) {
		// Remove any existing reference to avoid duplicates
		removeDelegate(delegate)
		// Add new delegate
		delegates.append(WeakDelegate(delegate: delegate))
		// Clean up nil references
		cleanupDelegates()
	}

	func removeDelegate(_ delegate: NotificationManagerDelegate) {
		delegates.removeAll { $0.delegate === delegate }
		cleanupDelegates()
	}

	func addDataUpdateDelegate(_ delegate: NotificationDataUpdateDelegate) {
		// Remove any existing reference to avoid duplicates
		removeDataUpdateDelegate(delegate)
		// Add new delegate
		dataUpdateDelegates.append(WeakDataUpdateDelegate(delegate: delegate))
		// Clean up nil references
		cleanupDataUpdateDelegates()
		// Immediately provide current notifications to the new delegate
		let currentNotifications = notificationService.currentNotifications
		if !currentNotifications.isEmpty {
			delegate.notificationManager(self, didReceiveNotifications: currentNotifications)
		}
	}

	func removeDataUpdateDelegate(_ delegate: NotificationDataUpdateDelegate) {
		dataUpdateDelegates.removeAll { $0.delegate === delegate }
		cleanupDataUpdateDelegates()
	}

	func startService() {
		notificationService.startPeriodicCheck()
	}

	func stopService() {
		notificationService.stopPeriodicCheck()
	}

	func markNotificationsAsRead() {
		notificationService.markNotificationsAsRead()
	}

	func checkNotificationsNow() {
		notificationService.checkNotifications()
	}

	func getCurrentNotifications() -> [NotificationCardViewModel] {
		return notificationService.currentNotifications
	}

	func hasNewNotifications() -> Bool {
		return notificationService.hasNewNotifications
	}

	// MARK: - Private Methods

	private func setupService() {
		notificationService.delegate = self
	}

	private func cleanupDelegates() {
		delegates.removeAll { $0.delegate == nil }
	}

	private func cleanupDataUpdateDelegates() {
		dataUpdateDelegates.removeAll { $0.delegate == nil }
	}

	private func notifyDelegates(hasNewNotifications: Bool) {
		// Clean up nil references first
		cleanupDelegates()
		// Notify all valid delegates
		for weakDelegate in delegates {
			weakDelegate.delegate?.notificationManager(self, didUpdateNotificationStatus: hasNewNotifications)
		}
	}

	private func notifyDataUpdateDelegates(notifications: [NotificationCardViewModel]) {
		// Clean up nil references first
		cleanupDataUpdateDelegates()
		// Notify all valid data update delegates
		for weakDelegate in dataUpdateDelegates {
			weakDelegate.delegate?.notificationManager(self, didReceiveNotifications: notifications)
		}
	}
}

// MARK: - NotificationServiceDelegate

extension NotificationManager: NotificationServiceDelegate {

	func notificationService(
		_ service: NotificationService,
		didUpdateNotificationStatus hasNewNotifications: Bool
	) {
		// Relay to all registered delegates
		notifyDelegates(hasNewNotifications: hasNewNotifications)
	}

	func notificationService(
		_ service: NotificationService,
		didReceiveNotifications notifications: [NotificationCardViewModel]
	) {
		// Handle notifications data - notify data update delegates
		notifyDataUpdateDelegates(notifications: notifications)
	}
}

// MARK: - WeakDelegate Helper

private class WeakDelegate {
	weak var delegate: NotificationManagerDelegate?

	init(delegate: NotificationManagerDelegate) {
		self.delegate = delegate
	}
}

private class WeakDataUpdateDelegate {
	weak var delegate: NotificationDataUpdateDelegate?

	init(delegate: NotificationDataUpdateDelegate) {
		self.delegate = delegate
	}
}
