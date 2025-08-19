//
//  UserRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//
import UIKit

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
        levelVC.modalPresentationStyle = .pageSheet   // или .formSheet, .fullScreen
        levelVC.modalTransitionStyle = .coverVertical // анимация появления
        viewController?.present(levelVC, animated: true, completion: nil)
    }
}
