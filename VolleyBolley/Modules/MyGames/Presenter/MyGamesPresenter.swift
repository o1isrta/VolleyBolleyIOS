//
//  MyGamesPresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol MyGamesPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class MyGamesPresenter: MyGamesPresenterProtocol {

    // MARK: - Public Properties

    weak var view: MyGamesViewProtocol?
    let interactor: MyGamesInteractorProtocol
    let router: MyGamesRouterProtocol

    // MARK: - Initializers

    init(
        interactor: MyGamesInteractorProtocol,
        router: MyGamesRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {
        let message = interactor.fetchGreeting()
        view?.showGreeting(message)

        interactor.loadUserData { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let (user, avatarImage)):
                let viewModel = NavBarViewModel(user: user, avatarImage: avatarImage)
                self.view?.displayNavBar(viewModel: viewModel)

            case .failure(let error):
                self.view?.displayError(message: error.localizedDescription)
            }
        }
    }
}
