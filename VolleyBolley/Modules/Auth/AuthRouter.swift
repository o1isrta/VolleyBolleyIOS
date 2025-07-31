//
//  AuthRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев
//

import UIKit


final class AuthRouter: AuthRouterProtocol {

    weak var viewController: UIViewController?

        static func assembleModule() -> UIViewController {
            let view = AuthViewController()
            let presenter = AuthorizationPresenter()
            let interactor = AuthorizationInteractor()
            let router = AuthRouter()

            view.presenter = presenter

            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router

            interactor.presenter = presenter
            router.viewController = view

            return view
        }

        func showPhoneAuth() {
//            let phoneAuthVC = PhoneRegRouter.assembleModule()
//            viewController?.navigationController?.pushViewController(phoneAuthVC, animated: true)
        }

        func showUserRegScreen() {
//            let userRegVC = UserRegRouter.assembleModule()
//            viewController?.navigationController?.pushViewController(userRegVC, animated: true)
        }
}
