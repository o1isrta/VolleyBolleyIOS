import UIKit

final class HomeAssembly {
    static func assemble() -> UIViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: nil)
        let presenter = HomePresenter(interactor: interactor, router: router)
        let view = HomeViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view
        return view
    }
}
