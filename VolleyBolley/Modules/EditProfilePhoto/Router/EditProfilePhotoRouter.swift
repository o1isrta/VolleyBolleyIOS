//
//  EditProfilePhotoRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoRouterProtocol: AnyObject {
	func attachViewController(_ view: UIViewController)
	func navigateBack()
}

final class EditProfilePhotoRouter: EditProfilePhotoRouterProtocol {

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
