import UIKit

final class TabBarViewController: UITabBarController {
    
    private let homeVC = HomeAssembly.assemble()
    private let gamesVC = MyGamesViewController()
    private let profileVC = ProfileViewController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        if #unavailable(iOS 26.0) {
            setValue(CustomTabBar(), forKey: "tabBar")
        }

        setupControllers()
        configureTabBarAppearance()

        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.addGradientLabels(titles: [
                String(localized: "tab_home"),
                String(localized: "tab_my_games"),
                String(localized: "tab_profile")
            ])
        }
    }

    private func setupControllers() {
        if #available(iOS 26.0, *) {
            homeVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_home"),
                image: .home,
                tag: 0
            )
            gamesVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_my_games"),
                image: UIImage(systemName: "volleyball"),
                tag: 1
            )
            profileVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_profile"),
                image: UIImage(systemName: "person"),
                tag: 2
            )

            let homeNav = UINavigationController(rootViewController: homeVC)
            let gamesNav = UINavigationController(rootViewController: gamesVC)
            let profileNav = UINavigationController(rootViewController: profileVC)

            setViewControllers([homeNav, gamesNav, profileNav], animated: false)
        } else {
            homeVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_home"),
                image: .home,
                selectedImage: AppGradient.iconGradientImage(named: .home)
            )
            gamesVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_my_games"),
                image: UIImage(systemName: "volleyball"),
                selectedImage: AppGradient.iconGradientImage(systemName: "volleyball")
            )
            profileVC.tabBarItem = UITabBarItem(
                title: String(localized: "tab_profile"),
                image: UIImage(systemName: "person"),
                selectedImage: AppGradient.iconGradientImage(systemName: "person")
            )

            let homeNav = UINavigationController(rootViewController: homeVC)
            let gamesNav = UINavigationController(rootViewController: gamesVC)
            let profileNav = UINavigationController(rootViewController: profileVC)

            setViewControllers([homeNav, gamesNav, profileNav], animated: false)
        }
    }

    private func configureTabBarAppearance() {
        let font = AppFont.Quantex.regular(size: 10)

        if #available(iOS 26.0, *) {
            let appearance = UITabBarAppearance()
            let normalColor = AppColor.Text.inverted
            let selectedColor = AppColor.Background.tabBar

            let layouts = [
                appearance.stackedLayoutAppearance,
                appearance.inlineLayoutAppearance,
                appearance.compactInlineLayoutAppearance
            ]

            for layout in layouts {
                layout.selected.iconColor = selectedColor
                layout.normal.titleTextAttributes = [.font: font, .foregroundColor: normalColor]
                layout.selected.titleTextAttributes = [.font: font, .foregroundColor: selectedColor]
            }

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance

            tabBar.tintColor = selectedColor
        } else {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundImage = nil
            appearance.backgroundColor = .clear

            let normalColor = AppColor.Text.primary

            let layouts = [
                appearance.stackedLayoutAppearance,
                appearance.inlineLayoutAppearance,
                appearance.compactInlineLayoutAppearance
            ]

            for layout in layouts {
                layout.selected.iconColor = .clear
                layout.normal.iconColor = normalColor
                layout.normal.titleTextAttributes = [.font: font, .foregroundColor: normalColor]

                layout.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
                layout.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
            }

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance

            tabBar.items?.forEach { $0.title = nil }
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let customTabBar = tabBar as? CustomTabBar {
            customTabBar.updateLabelStyles(selectedIndex: selectedIndex)
        }
    }
}
