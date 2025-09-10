//
//  NotificationsRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 31.08.2025.
//

import UIKit

protocol NotificationsRouterProtocol: AnyObject {
	var viewController: UIViewController? { get set }
	func navigateBack(from view: NotificationsViewControllerProtocol?)
}

final class NotificationsRouter: NotificationsRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?

	// MARK: - Public Methods

	func navigateBack(from view: NotificationsViewControllerProtocol?) {
		if let viewController = viewController {
			viewController.navigationController?.popViewController(animated: true)
		} else if let view = view as? UIViewController {
			view.navigationController?.popViewController(animated: true)
		}
	}
}
