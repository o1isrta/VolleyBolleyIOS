//
//  NewGameRouter.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 16.10.2025.
//

import UIKit

protocol NewGameRouterProtocol: AnyObject {
	var viewController: UIViewController? { get set }
	func routeToMain(with data: NewGameData?)
	func dismiss()
}

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
