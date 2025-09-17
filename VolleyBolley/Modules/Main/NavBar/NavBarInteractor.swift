//
//  NavBarInteractor.swift
//  VolleyBolley
//
//  Created by Qoder on 16.09.2025.
//

import Foundation
import UIKit

protocol NavBarInteractorInputProtocol: AnyObject {
	var presenter: NavBarInteractorOutputProtocol? { get set }

	func fetchUserData()
	func checkNotificationStatus()
	func fetchNotifications()
	func markNotificationsAsRead()
}

protocol NavBarInteractorOutputProtocol: AnyObject {
	func didFetchUserData(_ viewModel: NavBarViewModel)
	func didUpdateNotificationStatus(_ hasNewNotifications: Bool)
	func didUpdateNotifications(_ notifications: [NotificationCardViewModel])
	func didFetchNotifications(_ notifications: [NotificationCardViewModel])
	func didFailToFetchUserData(with error: Error)
}

final class NavBarInteractor: NavBarInteractorInputProtocol {

	// MARK: - Public Properties

	weak var presenter: NavBarInteractorOutputProtocol?

	// MARK: - Private Properties

	private var currentUser: User?
	private var hasNewNotifications: Bool = false
	private var notificationData: [NotificationCardViewModel] = []

	// MARK: - Public Methods

	func fetchUserData() {
		// TODO: fetch new data from a network service
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
			guard let self else { return }

			let mockUser = User(
				firstName: "Artem",
				lastName: "Ivanov",
				gender: 0,
				paymentID: 0,
				paymentAccount: "",
				dateOfBirth: Date(),
				level: UserLevel(rawValue: 1), // Slightly different from mock to show it's "fetched"
				countryID: 0,
				cityID: 0,
				avatarURL: nil
			)
			self.currentUser = mockUser
			let viewModel = NavBarViewModel(
				user: mockUser,
				avatarImage: UIImage(resource: .imgPerson)
			)

			self.presenter?.didFetchUserData(viewModel)
		}
	}

	func checkNotificationStatus() {
		// TODO: this would check for new notifications from a service
		// For now, we'll simulate this with mock data
		// May be we should have any cache to prevent very often requests
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			guard let self else { return }
			// Fetch notification data
			let newNotificationsData = NotificationCardViewModel.mockDataArray
			// old notifications found only
			if self.notificationData == newNotificationsData {
				self.hasNewNotifications = false
				self.presenter?.didUpdateNotificationStatus(self.hasNewNotifications)
				return
			}
			self.notificationData = newNotificationsData
			// Notify about data update
			self.presenter?.didUpdateNotifications(self.notificationData)
			// Notify about notification status
			self.hasNewNotifications = true
			self.presenter?.didUpdateNotificationStatus(self.hasNewNotifications)
		}
	}

	func fetchNotifications() {
		// Return the already fetched notification data
		presenter?.didFetchNotifications(notificationData)
	}

	func markNotificationsAsRead() {
		// Mark notifications as read in the business logic
		hasNewNotifications = false
		// Notify presenter about the state change
		presenter?.didUpdateNotificationStatus(hasNewNotifications)
	}
}
