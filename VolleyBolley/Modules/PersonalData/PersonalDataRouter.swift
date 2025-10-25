//
//  PersonalDataRouter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataRouter: PersonalDataRouterProtocol {

    // MARK: - Private Properties

	private let editProfilePhotoViewController: () -> EditProfilePhotoViewController?
	private weak var viewController: UIViewController?

	// MARK: - Initializers

	init(
		editProfilePhotoViewController: @escaping () -> EditProfilePhotoViewController?
	) {
		self.editProfilePhotoViewController = editProfilePhotoViewController
	}

    // MARK: - Public Methods

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

	func showEditProfilePhoto(with image: UIImage?) {
		guard
			let editProfilePhotoVC = editProfilePhotoViewController()
		else {
			fatalError("EditProfilePhotoViewController could not be created")
		}
		editProfilePhotoVC.presenter?.setupProfilePhoto(with: image)
		viewController?.navigationController?.pushViewController(editProfilePhotoVC, animated: true)
	}
}
