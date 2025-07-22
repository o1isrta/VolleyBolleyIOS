//
//  PhoneVerificationProtocol.swift
//  VolleyBolley
//
//  Created by Олег Кор on 20.07.2025.
//

import UIKit

protocol PhoneVerifyViewProtocol: AnyObject {
    func enableVerifyButton(_ isEnabled: Bool)
//    func showError(_ message: String)
//    func showLoading(_ isLoading: Bool)
}

protocol PhoneVerifyPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func codeDidChange(_ code: String)
    func didTapVerify(with code: String)
}

protocol PhoneVerifyInteractorProtocol: AnyObject {
    func verifyCode(_ code: String, for phoneNumber: String)
}

protocol PhoneVerifyInteractorOutputProtocol: AnyObject {
    func verificationSucceeded()
    func verificationFailed(with error: Error)
}

protocol PhoneVerifyRouterProtocol: AnyObject {
    static func assembleModule(with phoneNumber: String) -> UIViewController
    func navigateBack()
    func navigateToMainScreen()
}
