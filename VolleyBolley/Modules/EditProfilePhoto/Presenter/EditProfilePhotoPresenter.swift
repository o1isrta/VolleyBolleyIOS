//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoPresenterProtocol: AnyObject {
	func viewDidLoad()
	func backButtonTapped()
	func saveButtonTapped(image: UIImage)
	func didSelectAction(_ action: PhotoAction)
}

final class EditProfilePhotoPresenter: EditProfilePhotoPresenterProtocol {

	// MARK: - Public Properties

	weak var view: EditProfilePhotoViewControllerProtocol?
	let interactor: EditProfilePhotoInteractorProtocol
	let router: EditProfilePhotoRouterProtocol

	// MARK: - Initializers

	init(
		view: EditProfilePhotoViewControllerProtocol,
		interactor: EditProfilePhotoInteractorProtocol,
		router: EditProfilePhotoRouterProtocol
	) {
		self.view = view
		self.interactor = interactor
		self.router = router
	}

	// MARK: - Public Methods

	func viewDidLoad() {
		// TODO: - тут просто получаем фото с предыдущего экрана или из глобального хранилища User
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
			self?.view?.updateProfileImage(UIImage.imgPerson)
			print("setup image")
		}
	}

	func didSelectAction(_ action: PhotoAction) {
		switch action {
		case .chooseFromGallery:
			showPhotoLibrary()
		case .takePhoto:
			showCamera()
			view?.showLoading(false)
		case .deletePhoto:
			interactor.deleteProfilePhoto()
			setupDefaultProfilePhoto()
		}
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func saveButtonTapped(image: UIImage) {
		interactor.saveProfilePhoto(image: image)
	}
}

private extension EditProfilePhotoPresenter {

	func setupDefaultProfilePhoto() {
		let image = UIImage.Icon.profile
		view?.updateProfileImage(image)
	}

	// TODO: -
	func showPhotoLibrary() {
		guard let viewController = view as? UIViewController else { return }
		let profilePhotoPickerViewController = LibraryPhotoPickerService()
		profilePhotoPickerViewController.delegate = self
		profilePhotoPickerViewController.modalPresentationStyle = .fullScreen
		viewController.present(profilePhotoPickerViewController, animated: true)
	}

	// TODO: -
	func showCamera() {
		guard let viewController = view as? UIViewController else { return }

		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
			showErrorAlert(message: PhotoPickerError.cameraUnavailable.localizedDescription)
			return
		}

		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .camera
		imagePicker.delegate = viewController as? (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
		imagePicker.allowsEditing = true
		viewController.present(imagePicker, animated: true)
	}

	// TODO: -
	func showErrorAlert(message: String) {
		guard let viewController = view as? UIViewController else { return }
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		viewController.present(alert, animated: true)
	}
}

extension EditProfilePhotoPresenter: LibraryPhotoPickerServiceDelegate {

	func photoPickerDidSelectImage(_ image: UIImage) {
		view?.updateProfileImage(image)
	}

	func photoPickerDidCancel() {
		// действия при отмене выбора фото, если нужно
		print("Выбор фото отменен")
		view?.showLoading(false)
	}

	func photoPickerDidFailWithError(_ error: Error) {
		print("ErrorAlert")
		view?.showLoading(false)
		showErrorAlert(message: error.localizedDescription)
	}
}
