//
//  PhoneRegPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import Foundation

final class PhoneAuthPresenter: PhoneAuthPresenterProtocol {

    weak var view: PhoneAuthViewProtocol?
    var interactor: PhoneAuthInteractorProtocol?
    var router: PhoneAuthRouterProtocol?

    private var currentPhoneNumber: String = ""
    private var isNextButtonTapped: Bool = false

    init(view: PhoneAuthViewProtocol, interactor: PhoneAuthInteractorProtocol, router: PhoneAuthRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func didTapBack() {
        router?.navigateBack()
    }

    func didTapNextStep(with phoneNumber: String) {
        currentPhoneNumber = phoneNumber
        isNextButtonTapped = true
        interactor?.validatePhoneNumber(phoneNumber)
    }

    func phoneNumberDidChange(_ phoneNumber: String) {
        currentPhoneNumber = phoneNumber
        isNextButtonTapped = false
        interactor?.validatePhoneNumber(phoneNumber)
    }

    func hideNavigationBar() {
        router?.hideNavigationBar()
    }
}

extension PhoneAuthPresenter: PhoneAuthInteractorOutputProtocol {
    func didValidatePhoneNumber(isValid: Bool) {
        view?.setNextButtonActive(isValid)

        if isValid && isNextButtonTapped {
            router?.navigateToVerification(with: currentPhoneNumber)
        }
    }

    func didReceiveFormattedNumber(_ number: String) {
        view?.updatePhoneNumberText(number)
    }

    func didReceiveCountryCode(_ code: String) {
        view?.autoFillCountryCode(code)
    }
}
