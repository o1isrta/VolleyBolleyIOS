//
//  HomePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class HomePresenter: HomePresenterProtocol {

    // MARK: - Public Properties

    weak var view: HomeViewProtocol?

    // MARK: - Private Properties

    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    // MARK: - Initializers

    init(
        interactor: HomeInteractorProtocol,
        router: HomeRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)
    }
}
