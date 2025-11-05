//
//  HomeRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func start() -> UIViewController
    func showMap(for contentType: MapContentType)
    func showDonate()
}

final class HomeRouter: HomeRouterProtocol {

    // MARK: - Private Properties

    private let viewControllerFactory: () -> UIViewController
    private let mapFactory: (MapContentType) -> UIViewController

    private weak var navigationController: UINavigationController?

    // MARK: - Initializers

    init(
        viewControllerFactory: @escaping () -> UIViewController,
        mapFactory: @escaping (MapContentType) -> UIViewController
    ) {
        self.viewControllerFactory = viewControllerFactory
        self.mapFactory = mapFactory
    }

    // MARK: - Public Methods

    func start() -> UIViewController {
        let rootVC = viewControllerFactory()
        let nav = UINavigationController(rootViewController: rootVC)
        navigationController = nav
        return nav
    }

    func showMap(for contentType: MapContentType) {
        navigationController?.pushViewController(mapFactory(contentType), animated: true)
    }

    func showDonate() {
        print("HomeRouter - Show Donate")
    }
}
