//
//  NotificationsInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import Foundation

protocol NotificationsInteractorInputProtocol: AnyObject {
	var presenter: NotificationsInteractorOutputProtocol? { get set }

	func fetchNotifications()
	func refreshNotifications()
	func markNotificationsAsRead()
	func startListeningForUpdates()
	func stopListeningForUpdates()
}

protocol NotificationsInteractorOutputProtocol: AnyObject {
	func didFetchNotifications(_ notifications: [NotificationCardViewModel])
	func didFailToFetchNotifications(with error: Error)
}

final class NotificationsInteractor {

	// MARK: - Properties

	weak var presenter: NotificationsInteractorOutputProtocol?

	// MARK: - Private Properties

	private let notificationManager = NotificationManager.shared

	// MARK: - Initializer

	deinit {
		stopListeningForUpdates()
	}
}

// MARK: - NotificationsInteractorInputProtocol

extension NotificationsInteractor: NotificationsInteractorInputProtocol {

	/// Get current notifications from NotificationManager
	func fetchNotifications() {
		let notifications = notificationManager.getCurrentNotifications()
		presenter?.didFetchNotifications(notifications)
	}

	/// Trigger fresh notification check
	func refreshNotifications() {
		notificationManager.checkNotificationsNow()
	}

	/// Mark notifications as read through the service
	func markNotificationsAsRead() {
		notificationManager.markNotificationsAsRead()
	}

	/// Register for data updates from NotificationManager
	func startListeningForUpdates() {
		notificationManager.addDataUpdateDelegate(self)
	}

	/// Unregister from data updates
	func stopListeningForUpdates() {
		notificationManager.removeDataUpdateDelegate(self)
	}
}

// MARK: - NotificationDataUpdateDelegate

extension NotificationsInteractor: NotificationDataUpdateDelegate {

	/// Forward data updates to presenter
	func notificationManager(
		_ manager: NotificationManager,
		didReceiveNotifications notifications: [NotificationCardViewModel]
	) {
		presenter?.didFetchNotifications(notifications)
	}
}
