//
//  NavBarPresenter.swift
//  VolleyBolley
//
//  Created by Qoder on 16.09.2025.
//

import Foundation

protocol NavBarPresenterProtocol: AnyObject {
	var view: NavBarViewProtocol? { get set }
	var interactor: NavBarInteractorInputProtocol? { get set }
	var router: NavBarRouterProtocol? { get set }

	func viewIsReady()
	func viewWillAppear()
	func notificationButtonTapped()
	func refreshUserData()
}

final class NavBarPresenter: NavBarPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NavBarViewProtocol?
	var interactor: NavBarInteractorInputProtocol?
	var router: NavBarRouterProtocol?

	// MARK: - Private Properties

	private var currentViewModel: NavBarViewModel?
	private var hasNewNotifications: Bool = false
	private var notificationData: [NotificationCardViewModel] = []

	// MARK: - Public Methods

	func viewIsReady() {
		interactor?.fetchUserData()
	}

	func notificationButtonTapped() {
		// Fetch notifications from interactor before navigation
		interactor?.fetchNotifications()
		// Clear the notification badge after navigation
		if hasNewNotifications {
			hasNewNotifications = false
			view?.updateNotifications(hasNewNotifications)
			// Also update the business logic state
			interactor?.markNotificationsAsRead()
		}
	}

	func refreshUserData() {
		interactor?.fetchUserData()
		interactor?.checkNotificationStatus()
	}

	func viewWillAppear() {
		// Refresh notification status when view appears
		// This ensures state synchronization when navigating between screens
		interactor?.checkNotificationStatus()
	}
}

// MARK: - NavBarInteractorOutputProtocol

extension NavBarPresenter: NavBarInteractorOutputProtocol {

	func didFetchUserData(_ viewModel: NavBarViewModel) {
		currentViewModel = viewModel
		view?.configure(with: viewModel)
	}

	func didUpdateNotificationStatus(_ hasNewNotifications: Bool) {
		self.hasNewNotifications = hasNewNotifications
		view?.updateNotifications(hasNewNotifications)
	}

	func didUpdateNotifications(_ notifications: [NotificationCardViewModel]) {
		guard notificationData != notifications else {return }
		notificationData = notifications
		router?.updateNotificationsVC(with: notifications)
	}

	func didFetchNotifications(_ notifications: [NotificationCardViewModel]) {
		notificationData = notifications
		router?.showNotifications(with: notifications)
	}

	func didFailToFetchUserData(with error: Error) {
		// TODO: fail data needed
		guard let mockViewModel = currentViewModel else {
			let mockViewModel = NavBarViewModel.mockDefault
			currentViewModel = mockViewModel
			view?.configure(with: mockViewModel)
			return
		}
		view?.configure(with: mockViewModel)
	}
}
