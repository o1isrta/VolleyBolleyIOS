//
//  PersonalDataPresenter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import Foundation

final class PersonalDataPresenter: PersonalDataPresenterProtocol {

    // MARK: - Public Properties

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
    }

    func backButtonTapped() {
        router.navigateBack(from: view)
    }
}

extension PersonalDataPresenter: PersonalDataInteractorOutputProtocol {
    func didFetchCountries(_ countries: [String]) {
        self.countries = countries
        view?.updateCountries(countries)
    }
}
