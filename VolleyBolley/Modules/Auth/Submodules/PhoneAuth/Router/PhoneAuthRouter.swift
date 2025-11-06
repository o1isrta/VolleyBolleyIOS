//
//  PhoneRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Козырев on 17.08.2025.
//

import Swinject
import UIKit

protocol PhoneAuthRouterProtocol: AnyObject {
    func navigateBack()
    func hideNavigationBar()
}

final class PhoneAuthRouter: PhoneAuthRouterProtocol {

    weak var viewController: UIViewController?
    private let resolver: Resolver
    weak var coordinator: AppRouter?

    init(viewController: UIViewController, resolver: Resolver, coordinator: AppRouter?) {
        self.viewController = viewController
        self.resolver = resolver
        self.coordinator = coordinator
    }

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func hideNavigationBar() {
        viewController?.navigationController?.isNavigationBarHidden = true
    }
}
