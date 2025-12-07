//
//  RootViewControllerProviderAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import Swinject
import UIKit

struct RootViewControllerProviderAssembly: Assembly {

    func assemble(container: Container) {
        container.register(RootViewControllerProviding.self) { resolver in
            DefaultRootViewControllerProvider(
                window: resolver.safeResolve(UIWindow.self)
            )
        }.inObjectScope(.container)
    }
}
