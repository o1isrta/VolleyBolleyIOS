import Foundation

class AuthorizationInteractor: AuthInteractorProtocol {
    weak var presenter: AuthPresenterProtocol?
    
    func authWithGoogle() {
        presenter?.didAuthWithGoogleSuccess()
    }
    
    func authWithFacebook() {
        presenter?.didAuthWithFacebookSuccess()
    }
}
