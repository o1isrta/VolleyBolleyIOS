import UIKit

class AuthorizationRouter: AuthRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = AuthorizationView()
        let presenter = AuthorizationPresenter()
        let interactor = AuthorizationInteractor()
        let router = AuthorizationRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func showPhoneAuth() {
        let phoneAuthVC = PhoneRegRouter.assembleModule()
        viewController?.navigationController?.pushViewController(phoneAuthVC, animated: true)
    }
}
