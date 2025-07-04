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
        self.window = window

        let container = Container()
        let assembler = Assembler([
            AppAssembly(),
            AuthAssembly(),
            OnboardingAssembly()
        ], container: container)

        let router = AppRouter(window: window, assembler: assembler)
        self.appRouter = router

        let mainAssembly = MainAssembly(appRouter: router)
        assembler.apply(assembly: mainAssembly)

        router.start()

        window.makeKeyAndVisible()
    }
}
