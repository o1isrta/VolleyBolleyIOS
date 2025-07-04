import Foundation

protocol AuthViewProtocol: AnyObject {
   
}

protocol AuthPresenterProtocol: AnyObject {
    func phoneButtonTapped()
    func googleButtonTapped()
    func facebookButtonTapped()
}

protocol AuthInteractorProtocol: AnyObject {
    func authWithGoogle()
    func authWithFacebook()
}

protocol AuthRouterProtocol: AnyObject {
    func showPhoneAuth()
}
