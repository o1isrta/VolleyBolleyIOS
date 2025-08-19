//
//  PhoneRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//
import UIKit

class PhoneAuthRouter: PhoneAuthRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?

    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func navigateToVerification(with phoneNumber: String) {
        guard !phoneNumber.isEmpty else {
            assertionFailure("Attempted to navigate with empty phone number")
            return
        }

        coordinator?.showPhoneVerify()
    }
}
