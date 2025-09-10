//
//  EditProfilePhotoPresenter.swift
//  VolleyBolley
//
//  Created by Valery Zvonarev on 10.09.2025.
//

import Foundation

protocol EditProfilePhotoPresenterProtocol: AnyObject {
    func viewDidLoad()
    func backButtonTapped()
}

final class EditProfilePhotoPresenter: EditProfilePhotoPresenterProtocol {

    // MARK: - Public Properties

    weak var view: EditProfilePhotoPresenterProtocol?
    let interactor: EditProfilePhotoInteractorProtocol
    let router: EditProfilePhotoRouterProtocol

    // MARK: - Initializers

    init(
        interactor: EditProfilePhotoInteractorProtocol,
        router: EditProfilePhotoRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        interactor.loadData()
    }

    func backButtonTapped() {
        print("in Back button tapped - Presenter")
//        router.navigateBack(from: view)
    }
}
