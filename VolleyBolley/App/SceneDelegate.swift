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

        let window = UIWindow(windowScene: windowScene)
        DIContainer.initialize(window: window)

        guard let appRouter = DIContainer.shared.resolver.resolve(AppRouter.self) else {
            assertionFailure("Failed to resolve AppRouter from DIContainer")
            return
        }
        appRouter.start()

        window.makeKeyAndVisible()
    }
}
