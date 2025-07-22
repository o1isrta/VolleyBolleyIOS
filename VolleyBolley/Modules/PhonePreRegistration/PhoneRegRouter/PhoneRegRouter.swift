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
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToVerification(with phoneNumber: String) {
        let verificationVC = PhoneVerifyRouter.assembleModule(with: phoneNumber)
        viewController?.navigationController?.pushViewController(verificationVC, animated: true)
        
               DispatchQueue.main.async { [weak self] in
                   guard !phoneNumber.isEmpty else {
                       assertionFailure("Attempted to navigate with empty phone number")
                       return
                   }
                   
                   let verificationVC = PhoneVerifyRouter.assembleModule(with: phoneNumber)
                   
                   if let navigationController = self?.viewController?.navigationController {
                       navigationController.pushViewController(verificationVC, animated: true)
                   } else {
                       verificationVC.modalPresentationStyle = .fullScreen
                       self?.viewController?.present(verificationVC, animated: true)
                   }
               }
    }
}
