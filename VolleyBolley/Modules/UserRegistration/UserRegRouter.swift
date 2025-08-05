//
//  UserRegRouter.swift
//  VolleyBolley
//
//  Created by Олег Кор on 03.08.2025.
//
import UIKit

class UserRegRouter: UserRegRouterProtocol {

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
        // TODO: Сделать переход на экран описания уровней
    }
}
