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

    // MARK: - Initializers

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
