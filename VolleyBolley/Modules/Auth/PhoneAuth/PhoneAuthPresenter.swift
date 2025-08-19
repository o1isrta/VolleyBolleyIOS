//
//  PhoneRegPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Foundation

class PhoneAuthPresenter: PhoneAuthPresenterProtocol {

    weak var view: PhoneAuthViewProtocol?
    var interactor: PhoneAuthInteractorProtocol?
    var router: PhoneAuthRouterProtocol?

    private let minPhoneNumberLength = 10
    private let maxPhoneNumberLength = 15

    init(view: PhoneAuthViewProtocol, interactor: PhoneAuthInteractorProtocol, router: PhoneAuthRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func didTapBack() {
        router?.navigateBack()
    }

    func didTapNextStep(with phoneNumber: String) {
        interactor?.validatePhoneNumber(phoneNumber)
    }

    func phoneNumberDidChange(_ phoneNumber: String) {
        interactor?.validatePhoneNumber(phoneNumber)
    }
}

extension PhoneAuthPresenter: PhoneAuthInteractorOutputProtocol {
    func phoneValidationResult(isValid: Bool) {
        view?.setNextButtonActive(isValid)
        view?.updateNextButtonTitle(isValid ? String(localized: "send_code") : String(localized: "next_step"))
    }

    func didReceiveFormattedNumber(_ number: String) {
       // TODO: Форматирование номера
    }

    func didReceiveCountryCode(_ code: String) {
        view?.autoFillCountryCode(code)
    }
}
