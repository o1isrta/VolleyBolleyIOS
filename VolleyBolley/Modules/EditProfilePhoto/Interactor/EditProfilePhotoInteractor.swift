//
//  EditProfilePhotoInteractor.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import Foundation

protocol EditProfilePhotoInteractorProtocol: AnyObject {
    func loadData()
}

final class EditProfilePhotoInteractor: EditProfilePhotoInteractorProtocol {

    func loadData() {
        // Заглушка: загрузка фото
        print("Personal data loaded")
    }
}
