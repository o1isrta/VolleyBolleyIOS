import Foundation

protocol PhoneRegViewProtocol: AnyObject {
    
}

protocol PhoneRegPresenterProtocol: AnyObject {
    func didTapBack()
    func didTapNextStep(with phoneNumber: String)
}

protocol PhoneRegInteractorProtocol: AnyObject {
    func validatePhoneNumber(_ phoneNumber: String)
}

protocol PhoneRegRouterProtocol: AnyObject {
    func navigateBack()
    func navigateToVerification()
}
