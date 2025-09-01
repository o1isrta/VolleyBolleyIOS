//
//  PhoneVerifyRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 18.08.2025.
//
import Swinject
import UIKit

final class PhoneVerifyRouter: PhoneVerifyRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?

    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func navigateToMainScreen() {
        coordinator?.pushUserReg()
    }
}
