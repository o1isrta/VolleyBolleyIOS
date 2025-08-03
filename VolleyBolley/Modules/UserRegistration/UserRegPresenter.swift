//
//  UserRegPresenter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//
import Foundation

class UserRegPresenter: UserRegPresenterProtocol {
    var countries = ["Cyprus", "Thailand"]
    let cities = ["Koh Phangan", "Koh Samui"]

    weak var view: UserRegViewProtocol?
    var interactor: UserRegInteractorProtocol!
    var router: UserRegRouterProtocol!

    func viewDidLoad() {
        interactor.fetchCountries()
    }

    func didTapLevelInfo() {
        router?.showLevelInfoScreen()
    }

    func didTapGetStarted(name: String, surname: String, gender: String) {
        interactor.registerUser(name: name, surname: surname, gender: gender)
    }
}

extension UserRegPresenter: UserRegInteractorOutputProtocol {
    func didFetchCountries(_ countries: [String]) {
        self.countries = countries
        view?.updateCountries(countries)
    }

    func registrationDidSucceed() {
        router.navigateToNextScreen()
    }

    func registrationDidFail(error: Error) {

    }
}
