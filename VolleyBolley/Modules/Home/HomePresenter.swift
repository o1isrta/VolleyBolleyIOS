//
//  HomePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class HomePresenter: HomePresenterProtocol {

    // MARK: - Public Properties

    weak var view: HomeViewProtocol?
    let interactor: HomeInteractorProtocol
    let router: HomeRouterProtocol

    // MARK: - Initializers

    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)
    }
}
