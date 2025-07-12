import Foundation

class UserRegPresenter: UserRegPresenterProtocol {
    let countries = ["Cyprus", "Thailand"]
    let cities = ["Nicosia", "Bangkok"]
    
    weak var view: UserRegViewProtocol?
    var interactor: UserRegInteractorProtocol!
    var router: UserRegRouterProtocol!
    
    init(view: UserRegViewProtocol) {
        self.view = view
    }
    
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
