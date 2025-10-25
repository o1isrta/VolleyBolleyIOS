//
//  EditProfilePhotoInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoInteractorProtocol: AnyObject {
	func saveProfilePhoto(image: UIImage)
	func deleteProfilePhoto()
}

final class EditProfilePhotoInteractor: EditProfilePhotoInteractorProtocol {

	weak var presenter: EditProfilePhotoInteractorProtocol?

	init() {
		// тут нетворк сервис инитим
	}

	func saveProfilePhoto(image: UIImage) {
		// TODO: - сохранение фото профиля на бэкенд
		print("Profile photo downloaded to server")
	}

	func deleteProfilePhoto() {
		// TODO: - удаление фото профиля с бэкенда
		print("Profile photo removed from server")
	}
}
