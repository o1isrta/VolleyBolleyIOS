//
//  AboutPresenter.swift
//  VolleyBolley
//
//  Created by Demain Petropavlov on 05.09.2025.
//

// MARK: - AboutPresenterProtocol

protocol AboutPresenterProtocol: AnyObject {
    func viewDidLoad()
}

// MARK: - AboutPresenter

final class AboutPresenter: AboutPresenterProtocol {

    // MARK: - Dependencies

    weak var view: AboutViewProtocol?
    private let interactor: AboutInteractorProtocol
    private let router: AboutRouterProtocol

    // MARK: - Initializers

    init(interactor: AboutInteractorProtocol, router: AboutRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - AboutPresenterProtocol

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
