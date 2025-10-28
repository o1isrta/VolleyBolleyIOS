//
//  PhoneVerifyPresenter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 18.08.2025.
//

import UIKit

protocol PhoneVerifyPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func codeDidChange(_ code: String)
    func didTapResendCode()
    func didTapVerify(with code: String)
}

final class PhoneVerifyPresenter: PhoneVerifyPresenterProtocol, PhoneVerifyInteractorOutputProtocol {

    static let verificationCodeLength = 6

    weak var view: PhoneVerifyViewProtocol?
    var interactor: PhoneVerifyInteractorProtocol
    var router: PhoneVerifyRouterProtocol
    private let phoneNumber: String

    private var lastEnteredCode: String = ""

    init(view: PhoneVerifyViewProtocol,
         interactor: PhoneVerifyInteractorProtocol,
         router: PhoneVerifyRouterProtocol,
         phoneNumber: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.phoneNumber = phoneNumber
    }

    func viewDidLoad() {
        view?.enableVerifyButton(false)
        view?.hideError()
    }

    func didTapBack() {
        router.navigateBack()
    }

    func codeDidChange(_ code: String) {
        let digitsOnly = code.filter { $0.isNumber }
        lastEnteredCode = digitsOnly
        view?.hideError()
        if digitsOnly.count == Self.verificationCodeLength {
            interactor.verifyCodeForValidation(digitsOnly, for: phoneNumber)
            view?.enableVerifyButton(false)
        } else {
            view?.enableVerifyButton(false)
        }
    }

    func didTapVerify(with code: String) {
        let digitsOnly = code.filter { $0.isNumber }
        interactor.verifyCode(digitsOnly, for: phoneNumber)
    }

    func validationFailed(with error: Error) {
        view?.showError(error.localizedDescription)
        view?.enableVerifyButton(false)
    }

    func validationSucceeded() {
        view?.hideError()
        view?.enableVerifyButton(lastEnteredCode.count == Self.verificationCodeLength)
    }

    func verificationSucceeded() {
        router.navigateToMainScreen()
    }

    func verificationFailed(with error: Error) {
        view?.enableVerifyButton(false)
        view?.showError(error.localizedDescription)
    }

    func didTapResendCode() {
        interactor.resendCode(for: phoneNumber)
    }
}
