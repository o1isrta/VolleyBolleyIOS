import UIKit

final class TabBarViewController: UITabBarController {

    private var customTabBar: CustomTabBarView?

    private let homeVC = HomeAssembly.assemble()
    private let gamesVC = MyGamesViewController()
    private let profileVC = ProfileViewController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        if #unavailable(iOS 26.0) {
            setupCustomTabBarItems()
        } else {
            setupTabBarItems()
        }

        setViewControllers([homeVC, gamesVC, profileVC], animated: false)
        configureTabBarAppearance()
    }

    // MARK: - Setup
    private func setupTabBarItems() {
        homeVC.tabBarItem = UITabBarItem(
            title: String(localized: "tab_home"),
            image: .playHouseFill,
            tag: 0
        )
        gamesVC.tabBarItem = UITabBarItem(
            title: String(localized: "tab_my_games"),
            image: .volleyBallFill,
            tag: 1
        )
        profileVC.tabBarItem = UITabBarItem(
            title: String(localized: "tab_profile"),
            image: .personFill,
            tag: 2
        )
    }

    private func setupCustomTabBarItems() {
        let homeTabItem = CustomTabBarView.TabItem(
            title: String(localized: "tab_home"),
            image: .Icon.home
        )

        let gameTabItem = CustomTabBarView.TabItem(
            title: String(localized: "tab_my_games"),
            image: .Icon.volleyball
        )

        let profileTabItem = CustomTabBarView.TabItem(
            title: String(localized: "tab_profile"),
            image: .Icon.person
        )

        let customTabBar = CustomTabBarView(items: [homeTabItem, gameTabItem, profileTabItem])
        customTabBar.onSelectItem = { [weak self] index in
            self?.selectedIndex = index
        }

        tabBar.addSubview(customTabBar)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.topAnchor.constraint(equalTo: tabBar.topAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])

        self.customTabBar = customTabBar
    }

    // MARK: - Appearance
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

            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        customTabBar?.updateSelection(index: selectedIndex)
    }
}
