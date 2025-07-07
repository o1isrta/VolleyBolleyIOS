import Foundation

class PhoneRegPresenter: PhoneRegPresenterProtocol {
    
    weak var view: PhoneRegViewProtocol?
    var interactor: PhoneRegInteractorProtocol?
    var router: PhoneRegRouterProtocol?
    
    func didTapBack() {
        router?.navigateBack()
    }
    
    func didTapNextStep(with phoneNumber: String) {
        interactor?.validatePhoneNumber(phoneNumber)
    }
}
