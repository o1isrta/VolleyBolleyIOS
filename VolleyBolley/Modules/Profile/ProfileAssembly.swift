import UIKit

final class ProfileAssembly {
    static func assemble() -> UIViewController {
        let interactor = ProfileInteractor()
        let router = ProfileRouter(viewController: nil)
        let presenter = ProfilePresenter(interactor: interactor, router: router)
        let view = ProfileViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view
        return view
    }
}
