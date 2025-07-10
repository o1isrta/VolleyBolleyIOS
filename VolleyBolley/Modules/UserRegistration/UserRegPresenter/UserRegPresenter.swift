import Foundation

class UserRegPresenter: UserRegPresenterProtocol {
    
    weak var view: UserRegViewProtocol?
    var interactor: UserRegInteractorProtocol!
    var router: UserRegRouterProtocol!
    
    func didTapGetStarted(name: String, surname: String, gender: String) {
        interactor.registerUser(name: name, surname: surname, gender: gender)
    }
}

extension UserRegPresenter: UserRegInteractorOutputProtocol {
    func registrationDidSucceed() {
        router.navigateToNextScreen()
    }
    
    func registrationDidFail(error: Error) {
        // handle error, show alert
    }
}
