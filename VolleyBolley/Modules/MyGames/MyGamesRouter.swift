//
//  MyGamesRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesRouterProtocol: AnyObject {}

final class MyGamesRouter: MyGamesRouterProtocol {
    weak var viewController: UIViewController?

    // MARK: - Initializers

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
