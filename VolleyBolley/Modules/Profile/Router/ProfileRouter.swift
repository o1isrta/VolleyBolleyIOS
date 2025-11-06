//
//  ProfileRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func start() -> UIViewController
    func showPersonalData()
    func showSupport()
    func showFAQ()
	func showAbout()
}

final class ProfileRouter: ProfileRouterProtocol {

    // MARK: - Private Properties

    private let viewControllerFactory: () -> UIViewController
    private let personalDataFactory: () -> UIViewController
    private let supportFactory: () -> UIViewController
    private let faqFactory: () -> UIViewController
    private let aboutFactory: () -> UIViewController

    private weak var navigationController: UINavigationController?

    // MARK: - Initializers

    init(
        viewControllerFactory: @escaping () -> UIViewController,
        personalDataFactory: @escaping () -> UIViewController,
        supportFactory: @escaping () -> UIViewController,
        faqFactory: @escaping () -> UIViewController,
        aboutFactory: @escaping () -> UIViewController
    ) {
        self.viewControllerFactory = viewControllerFactory
        self.personalDataFactory = personalDataFactory
        self.supportFactory = supportFactory
        self.faqFactory = faqFactory
        self.aboutFactory = aboutFactory
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let rootVC = viewControllerFactory()
        let nav = UINavigationController(rootViewController: rootVC)
        navigationController = nav
        return nav
    }

    func showPersonalData() {
        navigationController?.pushViewController(personalDataFactory(), animated: true)
    }

    func showSupport() {
        navigationController?.pushViewController(supportFactory(), animated: true)
    }

    func showAbout() {
        navigationController?.pushViewController(aboutFactory(), animated: true)
    }

    func showFAQ() {
        navigationController?.pushViewController(faqFactory(), animated: true)
    }
}
