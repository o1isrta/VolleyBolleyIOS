//
//  MyGamesRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MyGamesRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
}

final class MyGamesRouter: MyGamesRouterProtocol {

    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }
}
