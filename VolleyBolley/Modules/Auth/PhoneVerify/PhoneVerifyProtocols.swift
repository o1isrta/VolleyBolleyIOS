//
//  PhoneVerifyProtocols.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import UIKit

protocol PhoneVerifyViewProtocol: AnyObject {
    func enableVerifyButton(_ isEnabled: Bool)
    func showError(_ message: String)
    func hideError()
}

protocol PhoneVerifyPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func codeDidChange(_ code: String)
    func didTapResendCode()
    func didTapVerify(with code: String)
}

protocol PhoneVerifyInteractorProtocol: AnyObject {
    func verifyCode(_ code: String, for phoneNumber: String)
    func resendCode(for phoneNumber: String)
    func verifyCodeForValidation(_ code: String, for phoneNumber: String)
}

protocol PhoneVerifyInteractorOutputProtocol: AnyObject {
    func verificationSucceeded()
    func verificationFailed(with error: Error)
    func validationFailed(with error: Error)
    func validationSucceeded()
}

protocol PhoneVerifyRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToMainScreen()
}
