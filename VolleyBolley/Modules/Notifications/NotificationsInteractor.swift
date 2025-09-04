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
}

protocol NotificationsInteractorOutputProtocol: AnyObject {
	func didFetchNotifications(_ notifications: [NotificationCardViewModel])
	func didFailToFetchNotifications(with error: Error)
}

final class NotificationsInteractor {

	// MARK: - Properties

	weak var presenter: NotificationsInteractorOutputProtocol?

	// MARK: - Private Properties

	// TODO: - for future
	// private let notificationsService: NotificationsServiceProtocol

	// MARK: - Initializer

	init(/*notificationsService: NotificationsServiceProtocol*/) {
		// self.notificationsService = notificationsService
	}
}

// MARK: - NotificationsInteractorInputProtocol

extension NotificationsInteractor: NotificationsInteractorInputProtocol {

	func fetchNotifications() {
		// TODO: get data from network
		let mockNotifications = NotificationCardViewModel.mockDataArray
		presenter?.didFetchNotifications(mockNotifications)
	}
}
