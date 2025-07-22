import Foundation

class PhoneRegPresenter: PhoneRegPresenterProtocol {
    
    weak var view: PhoneRegViewProtocol?
    var interactor: PhoneRegInteractorProtocol?
    var router: PhoneRegRouterProtocol?
    
    private var lastValidPhoneNumber: String?
    private let minPhoneNumberLength = 10
    private let maxPhoneNumberLength = 15
    
    func didTapBack() {
        router?.navigateBack()
    }
    
    func didTapNextStep(with phoneNumber: String) {
        if isPhoneNumberValid(phoneNumber) {
            router?.navigateToVerification(with: phoneNumber)
        } else {
            interactor?.validatePhoneNumber(phoneNumber)
        }
    }
    
    func phoneNumberDidChange(_ phoneNumber: String) {
        let isValid = isPhoneNumberValid(phoneNumber)
        view?.setNextButtonActive(isValid)
        view?.updateNextButtonTitle(isValid ? "SEND CODE" : "NEXT STEP")
    }
    
    private func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let digits = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return phoneNumber.hasPrefix("+") && digits.count >= 10 && digits.count <= 15
    }
}

    
    
    
    
