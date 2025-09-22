//
//  WindowAssembly.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 21.09.2025.
//

import Swinject
import UIKit

final class WindowAssembly: Assembly {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func assemble(container: Container) {
        container.register(UIWindow.self) { _ in
            self.window
        }.inObjectScope(.container)
    }
}
