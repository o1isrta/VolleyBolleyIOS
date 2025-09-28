//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

enum PhotoAction: Int {
    case chooseFromGallery = 0
    case takePhoto = 1
    case deletePhoto = 2
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
        interactor.loadData()
    }

    func didSelectAction(at index: Int) {
        guard let action = PhotoAction(rawValue: index) else { return }

        switch action {
            case .chooseFromGallery: // Choose from Gallery
                view?.showLoading(true)
                router.showPhotoLibrary()
            case .takePhoto: // Take photo
                view?.showLoading(true)
                router.showCamera()
            case .deletePhoto: // Delete photo
                view?.showLoading(true)
                interactor.deleteProfilePhoto()
        }
    }

    func backButtonTapped() {
        router.navigateBack()
    }

    func saveButtonTapped(image: UIImage) {
        interactor.saveProfilePhoto(image: image)
    }
}
