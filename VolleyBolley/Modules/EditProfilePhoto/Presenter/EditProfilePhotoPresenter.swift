//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import UIKit

final class EditProfilePhotoPresenter: EditProfilePhotoPresenterProtocol {

    // MARK: - Public Properties

    weak var view: EditProfilePhotoViewControllerProtocol?
    let interactor: EditProfilePhotoInteractorProtocol
    let router: EditProfilePhotoRouterProtocol
    var testNum = 155

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
        switch index
        {
            case 0: // Choose from Gallery
                view?.showLoading(true)
                router.showPhotoLibrary()
            case 1: // Take photo
                view?.showLoading(true)
                router.showCamera()
            case 2: // Delete photo
                view?.showLoading(true)
                interactor.deleteProfilePhoto()
            default:
                break
        }
    }

    func backButtonTapped() {
        router.navigateBack()
    }

    func saveButtonTapped(image: UIImage) {
        interactor.saveProfilePhoto(image: image)
    }
}
