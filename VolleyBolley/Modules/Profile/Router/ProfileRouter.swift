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

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func showPersonalData() {
        // TODO: - 111
        guard let personalDataVC = DIContainer.shared.resolver.resolve(PersonalDataViewController.self) else {
            fatalError("PersonalDataViewController не зарегистрирован")
        }

        viewController?.navigationController?.pushViewController(personalDataVC, animated: true)
    }
}
