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
			router.showPhotoLibrary(delegate: self)
		case .takePhoto:
			do {
				try router.showCamera()
			} catch let error {
				view?.showAlert(with: error.localizedDescription)
			}
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
		view?.showLoading(false)
	}

	func photoPickerDidFailWithError(_ error: Error) {
		view?.showLoading(false)
		view?.showAlert(with: error.localizedDescription)
	}
}
