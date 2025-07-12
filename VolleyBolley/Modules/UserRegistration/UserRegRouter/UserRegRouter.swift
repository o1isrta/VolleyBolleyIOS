import UIKit

class UserRegRouter: UserRegRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = UserRegViewController()
        let presenter = UserRegPresenter(view: view)
        let interactor = UserRegInteractor()
        let router = UserRegRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToNextScreen() {
        // Пример перехода
        // let nextVC = NextViewController()
        // viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}

