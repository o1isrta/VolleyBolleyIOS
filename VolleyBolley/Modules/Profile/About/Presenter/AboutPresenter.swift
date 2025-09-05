//
//  AboutPresenter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

protocol AboutPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class AboutPresenter: AboutPresenterProtocol {

    weak var view: AboutViewProtocol?
    private let interactor: AboutInteractorProtocol
    private let router: AboutRouterProtocol

    init(interactor: AboutInteractorProtocol, router: AboutRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        let info = interactor.fetchAboutInfo()
        let viewModel = AboutViewModel(
            founder: info.founder,
            designers: info.designers,
            developers: info.developers
        )
        view?.displayAboutInfo(viewModel)
    }
}

