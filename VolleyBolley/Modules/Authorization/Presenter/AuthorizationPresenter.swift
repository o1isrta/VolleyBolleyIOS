import Foundation

class AuthorizationPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?
    var interactor: AuthInteractorProtocol?
    var router: AuthRouterProtocol?
    
    func phoneButtonTapped() {
        router?.showPhoneAuth()
    }
    
    func googleButtonTapped() {
        interactor?.authWithGoogle()
    }
    
    func facebookButtonTapped() {
        interactor?.authWithFacebook()
    }
}

