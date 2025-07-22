//
//  PhoneVerificationRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 20.07.2025.
//
import UIKit

final class PhoneVerifyRouter: PhoneVerifyRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(with phoneNumber: String) -> UIViewController {
        let view = PhoneVerifyView(phoneNumber: phoneNumber)
        let interactor = PhoneVerifyInteractor()
        let router = PhoneVerifyRouter()
        let presenter = PhoneVerifyPresenter(
            view: view,
            interactor: interactor,
            router: router,
            phoneNumber: phoneNumber
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToMainScreen() {
//        // Реализация перехода на главный экран после успешной верификации
//        let mainVC = MainViewController()
//        viewController?.navigationController?.setViewControllers([mainVC], animated: true)
    }
}
