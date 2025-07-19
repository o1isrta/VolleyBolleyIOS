//
//  MainTabBarController.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import UIKit

final class MainTabBarController: UIViewController {

    // MARK: - Private Properties

    private var currentTab: TabBarItem = .home

    // MARK: - UI Components

    private var viewControllers: [TabBarItem: UIViewController] = [:]

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tabBar: CustomTabBarView = {
        let view = CustomTabBarView(items: TabBarItem.allCases)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupChildViewControllers()
    }

    func setViewControllers(_ viewControllers: [TabBarItem: UIViewController]) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        self.viewControllers = viewControllers
    }

    // MARK: - Setup

    private func setupView() {
        view.addSubview(containerView)
        view.addSubview(tabBar)
    }

    private func setupChildViewControllers() {
        for (tab, viewController) in viewControllers {
            addChild(viewController)
            containerView.addSubview(viewController.view)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            setupConstraintsForChild(viewController)
            viewController.didMove(toParent: self)
            viewController.view.isHidden = (tab != currentTab)
        }
    }

    // MARK: - Navigation

    private func switchToViewController(at tab: TabBarItem) {
        guard let selectedVC = viewControllers[tab] else { return }
        let previousVC = viewControllers[currentTab]

        previousVC?.view.isHidden = true
        selectedVC.view.isHidden = false

        currentTab = tab
        tabBar.updateSelection(index: tab.rawValue)
    }

    // MARK: - Layout setup

    private func setupLayout() {
        setupConstraintsContainerView()
        setupConstraintsTabBar()
    }

    // MARK: - Constraints

    private func setupConstraintsTabBar() {
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 81)
        ])
    }

    private func setupConstraintsContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupConstraintsForChild(_ selectedVC: UIViewController) {
        NSLayoutConstraint.activate([
            selectedVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            selectedVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            selectedVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            selectedVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

// MARK: - CustomTabBarViewDelegate

extension MainTabBarController: CustomTabBarViewDelegate {
    func customTabBarView(_ tabBarView: CustomTabBarView, didSelectItemAt index: Int) {
        guard let item = TabBarItem(rawValue: index) else { return }
        switchToViewController(at: item)
    }
}
