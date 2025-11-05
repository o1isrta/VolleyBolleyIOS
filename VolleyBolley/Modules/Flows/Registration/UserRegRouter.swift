//
//  UserRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//

import UIKit

protocol UserRegRouterProtocol: AnyObject {
    func showLevelInfoScreen()
    func navigateToNextScreen()
}

final class UserRegRouter: UserRegRouterProtocol {

    weak var viewController: UIViewController?
    weak var coordinator: AppRouter?

    init(viewController: UIViewController, coordinator: AppRouter?) {
        self.viewController = viewController
        self.coordinator = coordinator
    }

    func navigateToNextScreen() {
        // TODO: Сделать переход на следующий экран
    }

    func showLevelInfoScreen() {
        let levelVC = LevelInfoViewController()
        levelVC.modalPresentationStyle = .overFullScreen
        levelVC.modalTransitionStyle = .crossDissolve

        viewController?.present(levelVC, animated: true)
    }
}
