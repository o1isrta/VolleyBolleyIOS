import Foundation

protocol AuthViewProtocol: AnyObject {
    func setupUI()
}

protocol AuthPresenterProtocol: AnyObject {
    func phoneButtonTapped()
    func googleButtonTapped()
    func facebookButtonTapped()
}

protocol AuthInteractorProtocol: AnyObject {
    func authWithPhone()
    func authWithGoogle()
    func authWithFacebook()
}

protocol AuthRouterProtocol: AnyObject {
    func showPhoneAuth()
    func showGoogleAuth()
    func showFacebookAuth()
}



