//
//  ProfileRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {}

final class ProfileRouter: ProfileRouterProtocol {

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Initializers

    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
