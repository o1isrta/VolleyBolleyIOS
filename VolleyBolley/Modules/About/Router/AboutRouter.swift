//
//  AboutRouter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

import UIKit

// MARK: - AboutRouterProtocol

protocol AboutRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func navigateBack()
}

// MARK: - AboutRouter

final class AboutRouter: AboutRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
