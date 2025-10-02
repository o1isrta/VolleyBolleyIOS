//
//  NewGameRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 25.07.2025.
//

import UIKit

final class NewGameRouter: NewGameRouterProtocol {

    weak var viewController: UIViewController?

    func routeToMain(with data: NewGameData?) {
        let tabBar = MainTabBarController()
        viewController?.present(tabBar, animated: true)
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
