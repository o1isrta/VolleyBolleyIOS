//
//  ProfilePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class ProfilePresenter: ProfilePresenterProtocol {

    // MARK: - Public Properties

    weak var view: ProfileViewProtocol?
    let interactor: ProfileInteractorProtocol
    let router: ProfileRouterProtocol

    // MARK: - Initializers

    init(interactor: ProfileInteractorProtocol, router: ProfileRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)
    }
}
