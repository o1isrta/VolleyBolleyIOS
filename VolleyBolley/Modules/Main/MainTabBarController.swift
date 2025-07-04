//
//  MainTabBarController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(), forKey: "tabBar")
        setupTabs()
        configureAppearance()
    }

    private func setupTabs() {
        let home = UINavigationController(rootViewController: HomeAssembly.assemble())
        home.tabBarItem = UITabBarItem(
            title: "Home",
            image: .home,
            selectedImage: .homeActive
        )
        home.tabBarItem.tag = 0

        let games = UINavigationController(rootViewController: MyGamesAssembly.assemble())
        games.tabBarItem = UITabBarItem(
            title: "My Games",
            image: .myGames,
            selectedImage: .myGamesActive
        )
        games.tabBarItem.tag = 1

        let profile = UINavigationController(rootViewController: ProfileAssembly.assemble())
        profile.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .profile,
            selectedImage: .profileActive
        )
        profile.tabBarItem.tag = 2

        viewControllers = [home, games, profile]
    }

    private func configureAppearance() {
        let gradientSize = CGSize(width: 1, height: 50)
        let gradientImage = UIImage.gradientImage(size: gradientSize)
        let activeAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(patternImage: gradientImage!),
            .font: UIFont.systemFont(ofSize: 12, weight: .semibold)
        ]
        let inactiveAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]

        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = activeAttributes
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = inactiveAttributes
        tabBar.standardAppearance = appearance

        let inset: CGFloat = 4

        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: inset, left: 0, bottom: -inset, right: 0)
        }
    }
}
