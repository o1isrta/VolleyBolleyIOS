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

    // MARK: - Public Properties

    weak var viewController: UIViewController?

    // MARK: - Private Properties

    private let mapFactory: MapModuleFactoryProtocol

    // MARK: - Initializers

    init(mapFactory: MapModuleFactoryProtocol) {
        self.mapFactory = mapFactory
    }

    // MARK: - Public Methods

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
        openURL(AppConstants.Contacts.linktreeURL)
    }

    // MARK: - Private Methods

    private func openURL(_ url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
