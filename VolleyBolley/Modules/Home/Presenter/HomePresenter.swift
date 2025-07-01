protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    let interactor: HomeInteractorProtocol
    let router: HomeRouterProtocol

    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)
    }
}
