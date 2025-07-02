protocol MyGamesPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class MyGamesPresenter: MyGamesPresenterProtocol {
    weak var view: MyGamesViewProtocol?
    let interactor: MyGamesInteractorProtocol
    let router: MyGamesRouterProtocol

    init(interactor: MyGamesInteractorProtocol, router: MyGamesRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)
    }
}
