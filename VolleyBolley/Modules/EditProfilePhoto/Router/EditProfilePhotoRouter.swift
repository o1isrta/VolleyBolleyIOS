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
	func showPhotoLibrary(delegate: LibraryPhotoPickerServiceDelegate)
	func showCamera() throws(PhotoPickerError)
}

final class EditProfilePhotoRouter: EditProfilePhotoRouterProtocol {

	// MARK: - Public Properties

	private weak var viewController: UIViewController?

	// MARK: - Public Methods

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func showPhotoLibrary(delegate: LibraryPhotoPickerServiceDelegate) {
		guard let viewController else { return }
		let picker = LibraryPhotoPickerService()
		picker.delegate = delegate
		picker.modalPresentationStyle = .fullScreen
		viewController.present(picker, animated: true)
	}

	func showCamera() throws(PhotoPickerError) {
		guard let viewController else { return }

		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
			throw .cameraUnavailable
		}

		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .camera
		imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
		imagePicker.allowsEditing = true
		viewController.present(imagePicker, animated: true)
	}
}
