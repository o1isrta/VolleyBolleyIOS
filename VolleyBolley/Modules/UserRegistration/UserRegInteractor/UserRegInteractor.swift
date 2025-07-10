import Foundation

class UserRegInteractor: UserRegInteractorProtocol {
    
    weak var presenter: UserRegInteractorOutputProtocol?
    
    func registerUser(name: String, surname: String, gender: String) {
        // сетевой вызов регистрации
        
        if name.isEmpty || surname.isEmpty || gender.isEmpty {
            presenter?.registrationDidFail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "All fields required"]))
        } else {
            presenter?.registrationDidSucceed()
        }
    }
}
