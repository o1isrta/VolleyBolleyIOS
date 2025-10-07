//
//  FAQRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 01.10.2025.
//

import UIKit

protocol FAQRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func goBack()
}

final class FAQRouter: FAQRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func goBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}
}
