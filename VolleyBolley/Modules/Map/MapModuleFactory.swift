//
//  MapModuleFactory.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 15.09.2025.
//

import Swinject
import UIKit

protocol MapModuleFactoryProtocol {
    func makeMapForCreateGame() -> UIViewController
    func makeMapForFindGame() -> UIViewController
    func makeMapForCreateTourney() -> UIViewController
}

final class MapModuleFactory: MapModuleFactoryProtocol {

    // MARK: - Private Properties

    private let resolver: Resolver

    // MARK: - Initializers

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - Public Methods

    // TODO: - Add MapMode
    func makeMapForCreateGame() -> UIViewController {
        guard
            let viewController = resolver.resolve(MapViewController.self/*, argument: MapMode.createGame*/)
        else {
            fatalError("MapViewController not registered in DI")
        }

        return viewController
    }

    func makeMapForFindGame() -> UIViewController {
        guard
            let viewController = resolver.resolve(MapViewController.self/*, argument: MapMode.findGame*/)
        else {
            fatalError("MapViewController not registered in DI")
        }

        return viewController
    }

    func makeMapForCreateTourney() -> UIViewController {
        guard
            let viewController = resolver.resolve(MapViewController.self/*, argument: MapMode.createTourney*/)
        else {
            fatalError("MapViewController not registered in DI")
        }

        return viewController
    }
}
