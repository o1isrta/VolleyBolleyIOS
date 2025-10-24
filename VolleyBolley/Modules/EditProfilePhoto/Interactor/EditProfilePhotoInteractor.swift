//
//  EditProfilePhotoInteractor.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

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
