//
//  TabBarViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    private let homeVC = HomeViewController()
    private let gamesVC = MyGamesViewController()
    private let profileVC = ProfileViewController()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(CustomTabBar(), forKey: "tabBar")
        setupControllers()
        setupUITabBarItemAppearance()
    }
}

private extension TabBarViewController {
    
    // MARK: - setupControllers
    
    private func setupControllers() {
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "home_active")?.withRenderingMode(.alwaysOriginal)
        )
        gamesVC.tabBarItem = UITabBarItem(
            title: "My games",
            image: UIImage(named: "my_games")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "my_games_active")?.withRenderingMode(.alwaysOriginal)
        )
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "profile_active")?.withRenderingMode(.alwaysOriginal)
        )

        let homeNav = UINavigationController(rootViewController: homeVC)
        let gamesNav = UINavigationController(rootViewController: gamesVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        setViewControllers([homeNav, gamesNav, profileNav], animated: false)
    }
    
    // MARK: - setupUITabBarItemAppearance
    
    private func setupUITabBarItemAppearance() {
        let gradientSize = CGSize(width: 1, height: 50)
        let gradientImage = UIImage.gradientImage(with: UIColor.gradientColors, size: gradientSize)
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
    }
}
