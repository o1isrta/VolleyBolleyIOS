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

    init(
        interactor: ProfileInteractorProtocol,
        router: ProfileRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Public Methods

    func viewDidLoad() {

        Task { [weak self] in
            guard let self else { return }

            do {
                let (player, avatarImage) = try await interactor.loadPlayerData()

                await MainActor.run {
                    let navBarViewModel = NavBarViewModel(player: player, avatarImage: avatarImage)
                    self.view?.displayNavBar(viewModel: navBarViewModel)
                }
            } catch {
                await MainActor.run {
                    self.view?.displayError(message: error.localizedDescription)
                }
            }
        }
    }
}
