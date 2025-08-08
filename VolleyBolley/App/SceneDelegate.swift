//
//  SceneDelegate.swift
//  VolleyBolley
//
//  Created by Roman Romanov on 24.06.2025.
//

import Swinject
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appRouter: AppRouter?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

//        NetworkEnvironment.current = AppEnvironment.fromPlist()

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        DIContainer.initialize(window: window)

        guard let appRouter = DIContainer.shared.resolver.resolve(AppRouter.self) else {
            assertionFailure("Failed to resolve AppRouter from DIContainer")
            return
        }
        self.appRouter = appRouter

        appRouter.start()

        window.makeKeyAndVisible()
    }
}
