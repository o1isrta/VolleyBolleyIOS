//
//  OnboardingRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 12.07.2025.
//

import UIKit

class OnboardingRouter: OnboardingRouterProtocol {
    
    weak var viewController: UIViewController?
    weak var coordinator: AppCoordinator?
    
    static func assembleModule(coordinator: AppCoordinator?) -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        router.coordinator = coordinator
        
        return view
    }
    
    func navigateToAuthorizationScreen() {
//        coordinator?.showAuthorization()
    }
}
