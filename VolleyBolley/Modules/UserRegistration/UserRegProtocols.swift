import UIKit

protocol UserRegViewProtocol: AnyObject {}

protocol UserRegPresenterProtocol: AnyObject {
    var countries: [String] { get }
    var cities: [String] { get }
    
    func didTapGetStarted(name: String, surname: String, gender: String)
}

protocol UserRegInteractorProtocol: AnyObject {
    var presenter: UserRegInteractorOutputProtocol? { get set }
    
    func registerUser(name: String, surname: String, gender: String)
}

protocol UserRegInteractorOutputProtocol: AnyObject {
    func registrationDidSucceed()
    func registrationDidFail(error: Error)
}

protocol UserRegRouterProtocol: AnyObject {
    static func assembleModule() -> UIViewController
    func navigateToNextScreen()
}
