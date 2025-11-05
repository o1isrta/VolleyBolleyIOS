//
//  MainRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol MainRouterProtocol {
    func start() -> UIViewController
}

final class MainRouter: MainRouterProtocol {

    // MARK: - Private Properties

    private let homeRouter: HomeRouterProtocol
    private let myGamesRouter: MyGamesRouterProtocol
    private let profileRouter: ProfileRouterProtocol

    // MARK: - Initializers

    init(
        homeRouter: HomeRouterProtocol,
        myGamesRouter: MyGamesRouterProtocol,
        profileRouter: ProfileRouterProtocol
    ) {
        self.homeRouter = homeRouter
        self.myGamesRouter = myGamesRouter
        self.profileRouter = profileRouter
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let tabBarController = MainTabBarController()

        tabBarController.setViewControllers([
            .home: homeRouter.start(),
            .games: myGamesRouter.start(),
            .profile: profileRouter.start()
        ])

        return tabBarController
    }
}
