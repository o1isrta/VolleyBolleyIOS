//
//  RootViewControllerProvider.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko on 04.12.2025.
//

import UIKit

protocol RootViewControllerProviding {
    var rootViewController: UIViewController { get }
}

final class DefaultRootViewControllerProvider: RootViewControllerProviding {

    private weak var window: UIWindow?

    init(window: UIWindow) {
        self.window = window
    }

    var rootViewController: UIViewController {
        guard let root = window?.rootViewController else {
            fatalError("❌ RootViewController is not set")
        }
        return root
    }
}
