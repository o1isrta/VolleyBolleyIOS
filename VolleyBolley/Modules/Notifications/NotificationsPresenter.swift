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
	func backButtonTapped()
}

final class NotificationsPresenter: NotificationsPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NotificationsViewControllerProtocol?
	var interactor: NotificationsInteractorInputProtocol?
	var router: NotificationsRouterProtocol?

	// MARK: - Private Properties

	private var notifications: [NotificationCardViewModel] = []

	// MARK: - Public Methods

	func viewDidLoad() {
		if !notifications.isEmpty {
			view?.displayNotifications(notifications)
		} else {
			interactor?.fetchNotifications()
		}
	}

	func backButtonTapped() {
		router?.navigateBack(from: view)
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
