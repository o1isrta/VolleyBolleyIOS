//
//  EditProfilePhotoInteractor.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 25.10.2025.
//

import UIKit

protocol EditProfilePhotoInteractorProtocol: AnyObject {
	func saveProfilePhoto(image: UIImage?)
}

final class EditProfilePhotoInteractor: EditProfilePhotoInteractorProtocol {

	weak var presenter: EditProfilePhotoPresenterProtocol?

	init() {
		// TODO: - тут нетворк сервис инитим
	}

	func saveProfilePhoto(image: UIImage?) {
		// TODO: - сохранение фото профиля на бэкенд
		print("Profile photo downloaded to server")
	}
}
