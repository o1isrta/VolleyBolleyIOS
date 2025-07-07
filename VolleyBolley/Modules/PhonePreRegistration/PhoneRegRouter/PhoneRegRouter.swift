import UIKit

class PhoneRegRouter: PhoneRegRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = PhoneRegView()
        let presenter = PhoneRegPresenter()
        let interactor = PhoneRegInteractor()
        let router = PhoneRegRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.viewController = view
        
        return view
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToVerification() {
       
    }
}
