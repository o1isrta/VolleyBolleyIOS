//
//  PersonalDataPresenter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import UIKit

final class PersonalDataPresenter: PersonalDataPresenterProtocol {

    // MARK: - Public Properties

    var userData: UIImage?
    var countries = ["Cyprus", "Thailand"]
    let cities = ["Koh Phangan", "Koh Samui"]

    weak var view: PersonalDataViewProtocol?
    let interactor: PersonalDataInteractorProtocol
    let router: PersonalDataRouterProtocol

    // MARK: - Initializers

    init(
        interactor: PersonalDataInteractorProtocol,
        router: PersonalDataRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        interactor.fetchCountries()
		interactor.fetchUserData()
    }

    func backButtonTapped() {
        router.navigateBack()
    }

    func updateButtonTapped() {
        // TODO: Обновление профиля
    }

	func editProfilePhoto(image: UIImage?) {
		router.showEditProfilePhoto(with: image)
	}
}

extension PersonalDataPresenter: PersonalDataInteractorOutputProtocol {

    func didFetchCountries(_ countries: [String]) {
        self.countries = countries
        view?.updateCountries(countries)
    }

	// TODO: - draft
	func didFetchUserData(image: UIImage) {
		self.userData = image
        view?.updateUserData(image)
    }
}
