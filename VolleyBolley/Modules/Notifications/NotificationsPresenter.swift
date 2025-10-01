//
//  NotificationsPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import Foundation

protocol NotificationsPresenterProtocol: AnyObject {
	var view: NotificationsViewControllerProtocol? { get set }
	var interactor: NotificationsInteractorInputProtocol? { get set }
	var router: NotificationsRouterProtocol? { get set }

	func viewDidLoad()
	func viewWillAppear()
	func viewDidDisappear()
	func backButtonTapped()
	func refreshNotifications()
}

final class NotificationsPresenter: NotificationsPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NotificationsViewControllerProtocol?
	var interactor: NotificationsInteractorInputProtocol?
	var router: NotificationsRouterProtocol?

	// MARK: - Private Properties

	private var notifications: [NotificationCardViewModel] = []

	// MARK: - Deinit

	deinit {
		// Stop listening for updates when presenter is deallocated
		interactor?.stopListeningForUpdates()
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		// Start listening for updates and fetch initial data
		interactor?.startListeningForUpdates()
		interactor?.fetchNotifications()
	}

	func viewWillAppear() {
		// Optionally refresh data when view appears
		interactor?.fetchNotifications()
	}

	func viewDidDisappear() {
		// Mark notifications as read
		interactor?.markNotificationsAsRead()
	}

	func backButtonTapped() {
		router?.navigateBack(from: view)
	}

	func refreshNotifications() {
		// Trigger fresh data fetch from interactor
		interactor?.refreshNotifications()
	}
}

// MARK: - NotificationsInteractorOutputProtocol

extension NotificationsPresenter: NotificationsInteractorOutputProtocol {

	func didFetchNotifications(_ notifications: [NotificationCardViewModel]) {
		self.notifications = notifications

		if notifications.isEmpty {
			view?.displayEmptyState()
		} else {
			view?.displayNotifications(notifications)
		}
	}

	func didFailToFetchNotifications(with error: Error) {
		view?.displayEmptyState()
	}
}
