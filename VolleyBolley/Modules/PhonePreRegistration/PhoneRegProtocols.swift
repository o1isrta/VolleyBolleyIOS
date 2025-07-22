import UIKit

protocol PhoneRegViewProtocol: AnyObject {
    func setNextButtonActive(_ isActive: Bool)
    func updateNextButtonTitle(_ title: String)
//    func showLoading(_ isLoading: Bool)
//    func showError(_ message: String)
    func autoFillCountryCode(_ code: String)
}

protocol PhoneRegPresenterProtocol: AnyObject {
    func didTapBack()
    func didTapNextStep(with phoneNumber: String)
    func phoneNumberDidChange(_ phoneNumber: String)
}

protocol PhoneRegInteractorProtocol: AnyObject {
    func validatePhoneNumber(_ phoneNumber: String)
    func getCountryCallingCode() -> String?
    func formatPhoneNumber(_ phoneNumber: String) -> String
}

protocol PhoneRegInteractorOutputProtocol: AnyObject {
    func phoneValidationResult(isValid: Bool)
    func didReceiveFormattedNumber(_ number: String)
    func didReceiveCountryCode(_ code: String)
}

protocol PhoneRegRouterProtocol: AnyObject {
    static func assembleModule() -> UIViewController
    func navigateBack()
    func navigateToVerification(with phoneNumber: String)
}
