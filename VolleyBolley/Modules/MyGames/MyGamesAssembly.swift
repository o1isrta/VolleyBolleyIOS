import UIKit

final class MyGamesAssembly {
    static func assemble() -> UIViewController {
        let interactor = MyGamesInteractor()
        let router = MyGamesRouter(viewController: nil)
        let presenter = MyGamesPresenter(interactor: interactor, router: router)
        let view = MyGamesViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view
        return view
    }
}
