//
//  PersonalDataPresenter.swift
//  VolleyBolley
//
//  Created by Anastasia Evdokimovich on 01.09.2025.
//

import Foundation

protocol PersonalDataPresenterProtocol: AnyObject {
    func viewDidLoad()
    func backButtonTapped()
}

final class PersonalDataPresenter: PersonalDataPresenterProtocol {

    // MARK: - Public Properties

    weak var view: PersonalDataViewControllerProtocol?
    let interactor: PersonalDataInteractorProtocol
    let router: PersonalDataRouterProtocol

    // MARK: - Initializers

    init(
        interactor: PersonalDataInteractorProtocol,
        router: PersonalDataRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        interactor.loadData()
    }

    func backButtonTapped() {
        router.navigateBack(from: view)
    }
}
