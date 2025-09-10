//
//  PhoneRegProtocols.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 16.08.2025.
//
import UIKit

protocol PhoneAuthViewProtocol: AnyObject {
    func setNextButtonActive(_ isActive: Bool)
    func updateNextButtonTitle(_ title: String)
    func autoFillCountryCode(_ code: String)
    func updatePhoneNumberText(_ text: String)
}

protocol PhoneAuthPresenterProtocol: AnyObject {
    func didTapBack()
    func didTapNextStep(with phoneNumber: String)
    func phoneNumberDidChange(_ phoneNumber: String)
}

protocol PhoneAuthInteractorProtocol: AnyObject {
    var presenter: PhoneAuthInteractorOutputProtocol? { get set }
    func validatePhoneNumber(_ phoneNumber: String)
    func formatPhoneNumber(_ phoneNumber: String) -> String
}

protocol PhoneAuthInteractorOutputProtocol: AnyObject {
    func didValidatePhoneNumber(isValid: Bool)
    func didReceiveFormattedNumber(_ number: String)
    func didReceiveCountryCode(_ code: String)
}

protocol PhoneAuthRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToVerification(with phoneNumber: String)
}
