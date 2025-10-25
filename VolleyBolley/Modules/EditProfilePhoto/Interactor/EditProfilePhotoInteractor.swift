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

final class EditProfilePhotoInteractor: EditProfilePhotoInteractorProtocol {

	weak var presenter: EditProfilePhotoInteractorProtocol?

	init() {
		// тут нетворк сервис инитим
	}

	func loadData() {
		// TODO: - надо ли? получаем фото прямо из профиля, грузим тоже в профиле, тут чисто показываем текущую установленную
		// Заглушка: загрузка фото из бэкенда
		// print("Profile photo uploaded from server")
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
