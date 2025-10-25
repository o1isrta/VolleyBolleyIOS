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
	func showPhotoLibrary()
	func showCamera()
	func showErrorAlert(message: String)
}

final class EditProfilePhotoRouter: EditProfilePhotoRouterProtocol {

	// MARK: - Public Properties

	weak var viewController: UIViewController?
	weak var view: EditProfilePhotoViewControllerProtocol?
	var currentImage = UIImage()

	// MARK: - Initializers

	init(view: EditProfilePhotoViewControllerProtocol) {
		self.view = view
	}

	// MARK: - Public Methods

	func showPhotoLibrary() {
		guard let viewController = viewController else { return }
		let profilePhotoPickerViewController = ProfilePhotoPickerViewController()
		profilePhotoPickerViewController.delegate = self
		profilePhotoPickerViewController.modalPresentationStyle = .fullScreen
		viewController.present(profilePhotoPickerViewController, animated: true)
	}

	func showCamera() {
		guard let viewController = viewController else { return }

		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
			showErrorAlert(message: "Camera is not available on this device")
			return
		}

		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .camera
		imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
		imagePicker.allowsEditing = true
		viewController.present(imagePicker, animated: true)
	}

	func attachViewController(_ view: UIViewController) {
		viewController = view
	}

	func navigateBack() {
		viewController?.navigationController?.popViewController(animated: true)
	}

	func showErrorAlert(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		viewController?.present(alert, animated: true)
	}
}

extension EditProfilePhotoRouter: ProfilePhotoPickerViewControllerDelegate {
	func photoPickerDidSelectImage(_ image: UIImage) {
		view?.updateProfileImage(image)
	}

	func photoPickerDidCancel() {
		// действия при отмене выбора фото, если нужно
		print("Выбор фото отменен")
	}

	func photoPickerDidFailWithError(error: String) {
		showErrorAlert(message: error)
	}
}
