import Swinject

final class MyGamesAssembly: Assembly {

    func assemble(container: Container) {
        container.register(MyGamesViewController.self) { _ in
            let interactor = MyGamesInteractor()
            let router = MyGamesRouter(viewController: nil)
            let presenter = MyGamesPresenter(interactor: interactor, router: router)
            let view = MyGamesViewController(presenter: presenter)

            presenter.view = view
            router.viewController = view

            return view
        }
    }
}
