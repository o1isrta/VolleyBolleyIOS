//
//  EditProfilePhotoProtocols.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 21.09.2025.
//

import UIKit

protocol EditProfilePhotoViewControllerProtocol: AnyObject {
    func updateProfileImage(_ image: UIImage)
    func showLoading(_ isLoading: Bool)
}

protocol EditProfilePhotoPresenterProtocol: AnyObject {
    func viewDidLoad()
    func backButtonTapped()
    func saveButtonTapped(image: UIImage)
    func didSelectAction(at: Int)
}

protocol EditProfilePhotoInteractorProtocol: AnyObject {
    func loadData()
    func saveProfilePhoto(image: UIImage)
    func deleteProfilePhoto()
}

protocol EditProfilePhotoInteractorOutputProtocol: AnyObject {
    func saveProfilePhoto()
}

protocol EditProfilePhotoRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func navigateBack()
    func showPhotoLibrary()
    func showCamera()
    func showErrorAlert(message: String)
}

protocol ProfilePhotoPickerViewControllerDelegate: AnyObject {
    func photoPickerDidSelectImage(_ image: UIImage)
    func photoPickerDidCancel()
    func photoPickerDidFailWithError(error: String)
}
