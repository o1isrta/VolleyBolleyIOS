//
//  EditProfilePhotoInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoInteractorProtocol: AnyObject {
	func loadData()
	func saveProfilePhoto(image: UIImage)
	func deleteProfilePhoto()
}

protocol EditProfilePhotoInteractorOutputProtocol: AnyObject {
	func saveProfilePhoto()
}

final class EditProfilePhotoInteractor: EditProfilePhotoInteractorProtocol {

	weak var presenter: EditProfilePhotoInteractorProtocol?
	weak var view: EditProfilePhotoViewControllerProtocol?

	init(view: EditProfilePhotoViewControllerProtocol) {
		self.view = view
	}

	func loadData() {
		// Заглушка: загрузка фото из бэкенда
		// print("Profile photo uploaded from server")
	}

	func saveProfilePhoto(image: UIImage) {
		// Заглушка - сохранение фото профиля на бэкенд
		// print("Profile photo downloaded to server")
	}

	func deleteProfilePhoto() {
		let image = UIImage.Icon.profile
		view?.updateProfileImage(image)
	}
}
