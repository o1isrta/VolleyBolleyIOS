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
