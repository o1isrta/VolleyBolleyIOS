//
//  HomeRouter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import UIKit

protocol HomeRouterProtocol: AnyObject {
    func attachViewController(_ view: UIViewController)
    func showMapForCreateNewGame()
    func showMapForFindGame()
    func showMapForCreateTourney()
    func showDonate()
}

final class HomeRouter: HomeRouterProtocol {

    weak var viewController: UIViewController?
    private let mapFactory: MapModuleFactoryProtocol

    // MARK: - Initializers

    init(mapFactory: MapModuleFactoryProtocol) {
        self.mapFactory = mapFactory
    }

    func attachViewController(_ view: UIViewController) {
        viewController = view
    }

    func showMapForCreateNewGame() {
        let mapVC = mapFactory.makeMapForCreateGame()
        viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }

    func showMapForFindGame() {
        let mapVC = mapFactory.makeMapForFindGame()
        viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }

    func showMapForCreateTourney() {
        let mapVC = mapFactory.makeMapForCreateTourney()
        viewController?.navigationController?.pushViewController(mapVC, animated: true)
    }

    func showDonate() {
        print("HomeRouter - Show Donate")
    }
}
