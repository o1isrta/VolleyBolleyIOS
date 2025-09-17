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
		// TODO: In a real app, this would check for new notifications from a service
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
			guard let self else { return }
			// Fetch notification data first
			self.hasNewNotifications = self.notificationData != NotificationCardViewModel.mockDataArray
			print("Fetch notification data first", self.notificationData)// TODO: - Notifications
			print("Fetch notification data first", self.hasNewNotifications)// TODO: - Notifications
			guard self.hasNewNotifications == true else { return }
			// Simulate checking for notifications
			self.notificationData = NotificationCardViewModel.mockDataArray

			self.presenter?.didUpdateNotifications(self.notificationData)
			self.presenter?.didUpdateNotificationStatus(self.hasNewNotifications)
		}
	}

	func fetchNotifications() {
		// Return the already fetched notification data
		presenter?.didFetchNotifications(notificationData)
	}
}
