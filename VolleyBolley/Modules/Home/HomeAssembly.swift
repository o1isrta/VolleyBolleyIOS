import Swinject

final class HomeAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeViewController.self) { _ in
            let interactor = HomeInteractor()
            let router = HomeRouter(viewController: nil)
            let presenter = HomePresenter(interactor: interactor, router: router)
            let view = HomeViewController(presenter: presenter)

            presenter.view = view
            router.viewController = view

            return view
        }
    }
}
