import UIKit

class OnboardingRouter: OnboardingRouterProtocol {

    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
    
    func navigateToAuthorizationScreen() {
        // Example navigation:
        // let nextVC = NextViewController()
        // viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
