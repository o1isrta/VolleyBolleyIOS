import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
//        let homeVC = HomeAssembly.assemble()
        
        let homeVC = OnboardingRouter.assembleModule()

        window.rootViewController = UINavigationController(rootViewController: homeVC)
        self.window = window
        window.makeKeyAndVisible()
    }
}
