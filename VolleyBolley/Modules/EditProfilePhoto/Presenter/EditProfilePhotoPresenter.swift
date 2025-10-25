//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoPresenterProtocol: AnyObject {
	func backButtonTapped()
	func saveButtonTapped(image: UIImage?)
	func didSelectAction(_ action: PhotoAction)
	func setupProfilePhoto(with image: UIImage?)
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

	func didSelectAction(_ action: PhotoAction) {
		switch action {
		case .chooseFromGallery:
			router.showPhotoLibrary(delegate: self)
		case .takePhoto:
			do {
				try router.showCamera()
			} catch let error {
				view?.showAlert(with: error.localizedDescription)
			}
			view?.isLoadingIndicatorVisible(false)
		case .deletePhoto:
			setupProfilePhoto(with: nil)
		}
	}

	func backButtonTapped() {
		router.navigateBack()
	}

	func saveButtonTapped(image: UIImage?) {
		interactor.saveProfilePhoto(image: image)
	}

	func setupProfilePhoto(with image: UIImage?) {
		guard let image else {
			setupDefaultProfilePhoto()
			return
		}
		view?.updateProfileImage(image)
	}
}

// MARK: - Private Methods

private extension EditProfilePhotoPresenter {

	func setupDefaultProfilePhoto() {
		let image = UIImage.Icon.profile
		view?.updateProfileImage(image)
	}
}

// MARK: - LibraryPhotoPickerServiceDelegate

extension EditProfilePhotoPresenter: LibraryPhotoPickerServiceDelegate {

	func photoPickerDidSelectImage(_ image: UIImage) {
		view?.updateProfileImage(image)
	}

	func photoPickerDidCancel() {
		view?.isLoadingIndicatorVisible(false)
	}

	func photoPickerDidFailWithError(_ error: Error) {
		view?.isLoadingIndicatorVisible(false)
		view?.showAlert(with: error.localizedDescription)
	}
}
