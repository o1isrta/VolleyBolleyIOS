//
//  PhoneVerifyProtocols.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import UIKit

protocol PhoneVerifyViewProtocol: AnyObject {
    func enableVerifyButton(_ isEnabled: Bool)
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
//    var presenter: PhoneVerifyInteractorOutputProtocol? { get set }
    func verificationSucceeded()
    func verificationFailed(with error: Error)
}

protocol PhoneVerifyRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToMainScreen()
}
