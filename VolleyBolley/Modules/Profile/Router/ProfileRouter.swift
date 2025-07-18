//
//  ProfileRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
}

final class ProfileRouter: ProfileRouterProtocol {

    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }
}
