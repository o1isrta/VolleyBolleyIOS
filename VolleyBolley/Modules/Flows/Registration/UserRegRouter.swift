//
//  UserRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//

import UIKit

protocol UserRegRouterProtocol: AnyObject {
    var delegate: UserRegRouterDelegate? { get set }
    func start() -> UIViewController
    func finishRegistration()
    func showLevelInfo(onClose: @escaping () -> Void)
    func closeLevelInfo()
}

protocol UserRegRouterDelegate: AnyObject {
    func registrationDidFinish()
}

final class UserRegRouter: UserRegRouterProtocol {

    // MARK: - Public Properties

    weak var delegate: UserRegRouterDelegate?

    // MARK: - Private Properties

    private let viewControllerFactory: () -> UIViewController
    private weak var navigationController: UINavigationController?

    // MARK: - Initializers

    init(
        viewControllerFactory: @escaping () -> UIViewController
    ) {
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let rootVC = viewControllerFactory()
        let nav = UINavigationController(rootViewController: rootVC)
        navigationController = nav
        return nav
    }

    func finishRegistration() {
        delegate?.registrationDidFinish()
    }

    func showLevelInfo(onClose: @escaping () -> Void) {
        let viewController = LevelInfoViewController()
        viewController.onClose = onClose
        navigationController?.pushViewController(viewController, animated: true)
    }

    func closeLevelInfo() {
        navigationController?.popViewController(animated: true)
    }
}
