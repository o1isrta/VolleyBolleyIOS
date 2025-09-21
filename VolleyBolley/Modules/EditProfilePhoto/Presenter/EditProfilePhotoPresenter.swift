//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import Foundation

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
        print("in viewDidLoad - Presenter")
        interactor.loadData()
    }

    func didSelectAction(at index: Int) {
        switch index {
            case 0: // Choose from Gallery
                router.showPhotoLibrary()
            case 1: // Take photo
                router.showCamera()
            case 2: // Delete photo
                    //                view?.showLoading(true)
                interactor.deleteProfilePhoto()
            default:
                break
        }
    }

    func backButtonTapped() {
        print("in Back button tapped - Presenter")
        router.navigateBack()
    }

    func saveButtonTapped() {
        print("in Save button tapped - Presenter")
        //        router.navigateBack(from: view)
    }
}
