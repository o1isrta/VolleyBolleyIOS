//
//  UserRegPresenter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//

import Foundation

protocol UserRegPresenterProtocol: AnyObject {
    var countries: [String] { get }
    var cities: [String] { get }
    func didTapLevelInfo()
    func didTapGetStarted(name: String, surname: String, gender: String)
    func didTapToMain()
}

final class UserRegPresenter: UserRegPresenterProtocol {

    // MARK: - Public properties

    let cities = ["Koh Phangan", "Koh Samui"]

    weak var view: UserRegViewProtocol?
    var countries = ["Cyprus", "Thailand"]

    // MARK: - Private properties

    private let interactor: UserRegInteractorProtocol
    private let router: UserRegRouterProtocol
    private let finishRegistrationFlow: () -> Void

    // MARK: - Initializers

    init(
        interactor: UserRegInteractorProtocol,
        router: UserRegRouterProtocol,
        finishRegistrationFlow: @escaping () -> Void
    ) {
        self.interactor = interactor
        self.router = router
        self.finishRegistrationFlow = finishRegistrationFlow
    }

    func didTapLevelInfo() {
        router.showLevelInfo { [weak self] in
            self?.router.closeLevelInfo()
        }
    }

    func didTapGetStarted(name: String, surname: String, gender: String) {
        print("🕸️ UserRegPresenter - didTapGetStarted - name: \(name), surname: \(surname), gender: \(gender)")
        //        interactor.registerUser(name: name, surname: surname, gender: gender)
    }

    func didTapToMain() {
        router.finishRegistration()
    }
}

// MARK: - AuthInteractorOutput

extension UserRegPresenter: UserRegInteractorOutputProtocol {

    func didRegisterSuccessfully(isRegistered: Bool) {
        if isRegistered {
            print("✅ UserRegPresenter - didRegisterSuccessfully - isRegistered: \(isRegistered)")
            finishRegistrationFlow()
        } else {
            print("✅ UserRegPresenter - didRegisterSuccessfully - isRegistered: \(isRegistered)")
            //            view?.showRegistrationScreen()
        }
    }

    func didFailToRegister(error: Error) {
        //        view?.showError(error.localizedDescription)
        print("❌ UserRegPresenter - didFailToRegister - error: \(error)")
    }
}
