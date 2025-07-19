//
//  MainTabBarController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Private Properties

    private struct TabIcon {
        let title: String
        let image: UIImage?
        let selected: UIImage?
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(), forKey: "tabBar")
        configureAppearance()
    }

    // MARK: - Public Methods

    func configureTabBarItems() {
        guard let items = tabBar.items else { return }

        let icons: [TabIcon] = [
            TabIcon(title: "Home", image: .home, selected: .homeActive),
            TabIcon(title: "My Games", image: .myGames, selected: .myGamesActive),
            TabIcon(title: "Profile", image: .profile, selected: .profileActive)
        ]

        for (index, item) in items.enumerated() {
            let data = icons[index]
            item.title = data.title
            item.image = data.image
            item.selectedImage = data.selected
            item.tag = index
        }
    }

    // MARK: - Public Methods

    private func configureAppearance() {
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
