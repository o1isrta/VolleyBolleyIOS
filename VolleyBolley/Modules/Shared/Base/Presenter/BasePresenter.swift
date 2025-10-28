//
//  BasePresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.09.2025.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
	var view: NavBarViewProtocol? { get set }
	var interactor: BaseInteractorInputProtocol? { get set }
	var router: BaseRouterProtocol? { get set }

	func viewIsReady()
	func notificationButtonTapped()
}

final class BasePresenter: BasePresenterProtocol {

	// MARK: - Public Properties

	weak var view: NavBarViewProtocol?
	var interactor: BaseInteractorInputProtocol?
	var router: BaseRouterProtocol?

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

extension BasePresenter: BaseInteractorOutputProtocol {

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
