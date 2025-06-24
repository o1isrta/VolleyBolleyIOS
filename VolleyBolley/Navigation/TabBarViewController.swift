//
//  TabBarViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    private let homeVC = HomeViewController()
    private let gamesVC = MyGamesViewController()
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(CustomTabBar(), forKey: "tabBar")
        setupControllers()
    }
}

private extension TabBarViewController {
    
    // MARK: - setupControllers
    
    private func setupControllers() {
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        gamesVC.tabBarItem = UITabBarItem(title: "My Games", image: UIImage(named: "my_games"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)


        let homeNav = UINavigationController(rootViewController: homeVC)
        let gamesNav = UINavigationController(rootViewController: gamesVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        setViewControllers([homeNav, gamesNav, profileNav], animated: false)
    }
    
}
