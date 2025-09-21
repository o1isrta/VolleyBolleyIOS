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
        print("Personal data loaded")
    }

    func deleteProfilePhoto() {
        print("deleteProfilePhoto Interactor")
        //        let image = UIImage(systemName: "person.circle.fill") ?? UIImage()
        let image = UIImage.Icon.profile
        view?.updateProfileImage(image)
    }
}

