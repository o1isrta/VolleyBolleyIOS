//
//  BaseInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.09.2025.
//

import Foundation
import UIKit

protocol BaseInteractorInputProtocol: AnyObject {
	var presenter: BaseInteractorOutputProtocol? { get set }

	func fetchUserData()
	func fetchNotifications()
}

protocol BaseInteractorOutputProtocol: AnyObject {
	func didFetchUserData(_ viewModel: NavBarViewModel)
	func didFetchNotifications(_ notifications: [NotificationCardViewModel])
	func didFailToFetchUserData(with error: Error)
}

final class BaseInteractor: BaseInteractorInputProtocol {

	// MARK: - Public Properties

	weak var presenter: BaseInteractorOutputProtocol?

	// MARK: - Private Properties

	private var currentUser: Player?
	private var notificationData: [NotificationCardViewModel] = []

	// MARK: - Public Methods

	func fetchUserData() {
		// TODO: fetch new data from a network service - need to remove it from BaseInteractor
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
			guard let self else { return }

			let mockUser = Player.mockDefault
			self.currentUser = mockUser
			let viewModel = NavBarViewModel.mockDefault

			self.presenter?.didFetchUserData(viewModel)
		}
	}

	func fetchNotifications() {
		// Return the already fetched notification data
		presenter?.didFetchNotifications(notificationData)
	}
}
