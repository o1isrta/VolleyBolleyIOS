//
//  NotificationsAssembly.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import Swinject
import UIKit

final class NotificationsAssembly: Assembly {

	static func createModule(with initialData: [NotificationCardViewModel]) -> UIViewController {
		let view = NotificationsViewController()
		let interactor = NotificationsInteractor()
		let router = NotificationsRouter()
		let presenter = NotificationsPresenter()
		// Connect VIPER components
		view.presenter = presenter
		presenter.view = view
		presenter.interactor = interactor
		presenter.router = router
		interactor.presenter = presenter
		router.viewController = view
		// If we have initial data, provide it to presenter
		if !initialData.isEmpty {
			presenter.didFetchNotifications(initialData)
		}

		return view
	}

	func assemble(container: Container) {
		container.register(NotificationsViewController.self) { _ in
			let notificationsVC = NotificationsViewController()
			let interactor = NotificationsInteractor()
			let router = NotificationsRouter()
			let presenter = NotificationsPresenter()

			notificationsVC.presenter = presenter
			presenter.view = notificationsVC
			presenter.interactor = interactor
			presenter.router = router
			interactor.presenter = presenter
			router.viewController = notificationsVC

			return notificationsVC
		}
	}
}
