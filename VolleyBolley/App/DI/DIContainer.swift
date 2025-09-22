//
//  DIContainer.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Swinject
import UIKit

final class DIContainer {
    let assembler: Assembler
    var resolver: Resolver { assembler.resolver }

    static var shared: DIContainer {
        guard let instance = _shared else {
            fatalError(
                "DIContainer.shared accessed before being initialized. Call DIContainer.initialize(window:) first."
            )
        }
        return instance
    }

    // MARK: - Private Properties

    private static var _shared: DIContainer?

    // MARK: - Initializers

    init(window: UIWindow) {
        assembler = Assembler(
            [
                CoreAssemblies.all(window: window),
                FeatureAssemblies.all
            ].flatMap { $0 }
        )
    }

    static func initialize(window: UIWindow) {
        precondition(_shared == nil, "DIContainer already initialized")
        _shared = DIContainer(window: window)
    }
}
