//
//  TabBarViewController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Private Properties
    
    private let homeVC = HomeAssembly.assemble()
    private let gamesVC = MyGamesViewController()
    private let profileVC = ProfileViewController()
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(CustomTabBar(), forKey: "tabBar")
        setupControllers()
        setupUITabBarItemAppearance()
    }
}

// MARK: - Private Methods

private extension TabBarViewController {
    
    func setupControllers() {
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: .home,
            selectedImage: .homeActive
        )
        gamesVC.tabBarItem = UITabBarItem(
            title: "My games",
            image: .myGames,
            selectedImage: .myGamesActive
        )
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .profile,
            selectedImage: .profileActive
        )

        let homeNav = UINavigationController(rootViewController: homeVC)
        let gamesNav = UINavigationController(rootViewController: gamesVC)
        let profileNav = UINavigationController(rootViewController: profileVC)

        setViewControllers([homeNav, gamesNav, profileNav], animated: false)
    }
    
    func setupUITabBarItemAppearance() {
        let gradientSize = CGSize(width: 1, height: 50)
        let gradientImage = UIImage.gradientImage(size: gradientSize)
        
        guard let gradientImage else { return }
        
        let activeAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(patternImage: gradientImage),
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
