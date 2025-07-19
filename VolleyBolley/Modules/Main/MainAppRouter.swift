//
//  MainAppRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

protocol MainAppRouterProtocol {
    func start() -> UIViewController
}

final class MainAppRouter: MainAppRouterProtocol {

    // MARK: - Private Properties

    private let resolver: Resolver

    // MARK: - Initializers

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let tabBarController = MainTabBarController()

        guard let home = resolver.resolve(HomeViewController.self) else {
            fatalError("HomeViewController dependency could not be resolved.")
        }
        guard let games = resolver.resolve(MyGamesViewController.self) else {
            fatalError("MyGamesViewController dependency could not be resolved.")
        }
        guard let profile = resolver.resolve(ProfileViewController.self) else {
            fatalError("ProfileViewController dependency could not be resolved.")
        }

        tabBarController.setViewControllers([
            UINavigationController(rootViewController: home),
            UINavigationController(rootViewController: games),
            UINavigationController(rootViewController: profile)
        ], animated: false)

        tabBarController.configureTabBarItems()

        return tabBarController
    }
}
