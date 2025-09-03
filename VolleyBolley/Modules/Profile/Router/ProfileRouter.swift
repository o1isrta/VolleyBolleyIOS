//
//  ProfileRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func showPersonalData()
}

final class ProfileRouter: ProfileRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?

    init(coordinator: AppRouter?) {
        self.coordinator = coordinator
    }

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func showPersonalData() {
        coordinator?.showPersonalData()
    }
}
