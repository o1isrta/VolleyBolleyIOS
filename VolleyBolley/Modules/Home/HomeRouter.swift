//
//  HomeRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeRouterProtocol: AnyObject {}

final class HomeRouter: HomeRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Public Properties

    func attachViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}
