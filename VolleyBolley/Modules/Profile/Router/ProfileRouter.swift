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
    func showFAQ()
}

final class ProfileRouter: ProfileRouterProtocol {

    weak var viewController: UIViewController?

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func showPersonalData() {
        guard let personalDataVC = DIContainer.shared.resolver.resolve(PersonalDataViewController.self) else {
            fatalError("PersonalDataViewController не зарегистрирован")
        }

        viewController?.navigationController?.pushViewController(personalDataVC, animated: true)
    }

    func showFAQ() {
        guard let faqVC = DIContainer.shared.resolver.resolve(FAQViewController.self) else {
            fatalError("FAQViewController не зарегистрирован")
        }

        viewController?.navigationController?.pushViewController(faqVC, animated: true)
    }
}