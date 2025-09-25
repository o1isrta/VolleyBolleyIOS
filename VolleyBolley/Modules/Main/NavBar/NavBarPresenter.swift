//
//  NavBarPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.09.2025.
//

import Foundation

protocol NavBarPresenterProtocol: AnyObject {
	var view: NavBarViewProtocol? { get set }
	var interactor: NavBarInteractorInputProtocol? { get set }
	var router: NavBarRouterProtocol? { get set }

	func viewIsReady()
	func notificationButtonTapped()
}

final class NavBarPresenter: NavBarPresenterProtocol {

	// MARK: - Public Properties

	weak var view: NavBarViewProtocol?
	var interactor: NavBarInteractorInputProtocol?
	var router: NavBarRouterProtocol?

	// MARK: - Private Properties

	private var currentViewModel: NavBarViewModel?
	private var notificationData: [NotificationCardViewModel] = []

	// MARK: - Public Methods

	func viewIsReady() {
		interactor?.fetchUserData()
	}

	func notificationButtonTapped() {
		// Fetch notifications from interactor before navigation
		interactor?.fetchNotifications()
	}
}

// MARK: - NavBarInteractorOutputProtocol

extension NavBarPresenter: NavBarInteractorOutputProtocol {

	func didFetchUserData(_ viewModel: NavBarViewModel) {
		currentViewModel = viewModel
		view?.configure(with: viewModel)
	}

	func didFetchNotifications(_ notifications: [NotificationCardViewModel]) {
		notificationData = notifications
		router?.showNotifications(with: notifications)
	}

	func didFailToFetchUserData(with error: Error) {
		// TODO: fail data needed, show alert may be
		print("fail data recieved")
//		view?.configure(with: error)
	}
}
