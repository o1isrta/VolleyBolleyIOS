//
//  ProfilePresenter.swift
//  VolleyBolley
//
//  Created by Nikolai Eremenko
//

protocol ProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectMenuItem(_ item: ProfileMenuItem)
}

final class ProfilePresenter: ProfilePresenterProtocol {

    // MARK: - Public Properties

    weak var view: ProfileViewProtocol?
    let interactor: ProfileInteractorProtocol
    let router: ProfileRouterProtocol

    // MARK: - Initializers

    init(
        interactor: ProfileInteractorProtocol,
        router: ProfileRouterProtocol
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

    func didSelectMenuItem(_ item: ProfileMenuItem) {
        switch item {
        case .personal:
            router.showPersonalData()
        default:
            break
        }
    }
}
