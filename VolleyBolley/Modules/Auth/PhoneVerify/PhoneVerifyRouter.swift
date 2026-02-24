//
//  PhoneVerifyRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//

import Swinject
import UIKit

final class PhoneVerifyRouter: PhoneVerifyRouterProtocol {

    private weak var viewController: UIViewController?
    private weak var router: AppRouter?

    init(viewController: UIViewController, router: AppRouter?) {
        self.viewController = viewController
        self.router = router
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func navigateToMainScreen() {
		router?.pushRegistrationScreen()
    }
}
