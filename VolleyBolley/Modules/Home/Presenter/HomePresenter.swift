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
