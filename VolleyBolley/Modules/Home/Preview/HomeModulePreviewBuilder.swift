#if DEBUG
import UIKit

enum HomeModulePreviewBuilder {
    static func build() -> UIViewController {
        let interactor = MockHomeInteractor()
        let router = MockHomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view

        return UINavigationController(rootViewController: view)
    }

    // Можно добавить доп сценарии
}
#endif
